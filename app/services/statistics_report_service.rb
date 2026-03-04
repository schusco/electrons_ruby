class StatisticsReportService
  def self.career_hitting_stats(player)
    sql = <<~SQL
    SELECT  YEAR(gs.Game_Date) as year,
      gs.Playoff as playoff,
      count(*) as games,
      SUM(AB) as ab,
      SUM(R) as r,
      SUM(H) as h,
      SUM(`2B`) as doubles,
      SUM(`3B`) AS triples,
      SUM(HR) AS hr,
      SUM(RBI) AS rbi,#{' '}
      SUM(BB) AS bb,#{' '}
      SUM(HBP) AS hbp,#{' '}
      SUM(K) AS k,#{' '}
      SUM(SB) AS sb,#{' '}
      SUM(CS) AS cs,#{' '}
      SUM(SAC) AS sac,#{' '}
      SUM(SF) AS sf,#{' '}
      SUM(LOB) AS lob
    FROM hittingstats hs
    JOIN gameschedule gs ON hs.Game_ID = gs.Game_ID
    WHERE hs.Player_ID = #{player.id}
    GROUP BY YEAR(gs.Game_Date), gs.Playoff
    ORDER BY year ASC
    SQL
    ActiveRecord::Base.connection.select_all(sql).map { |row| HittingStatsRow.from(row) }
  end

  def self.career_hitting_totals(player)
    stats = career_hitting_stats(player)
    get_hitting_totals(stats)
  end
  def self.career_pitching_stats(player)
          player.pitching_stats.joins(:gameschedule)
      .group("YEAR(gameschedule.Game_Date), gameschedule.Playoff")
      .select("YEAR(gameschedule.Game_Date) AS year, gameschedule.Playoff AS playoff, Player_ID, MIN(gameschedule.Game_ID) AS Game_ID, SUM(GS) AS GS,
      SUM(IP) AS IP, SUM(ER) AS ER, SUM(H) AS H, SUM(BB) AS BB, SUM(K) AS K, MIN(Decision) as Decision,
      SUM(CASE WHEN Decision = 'W' or Decision = 'BS,W' THEN 1 ELSE 0 END) as wins,
      SUM(CASE WHEN Decision = 'L' or Decision = 'BS,L' THEN 1 ELSE 0 END) as losses,
      SUM(CASE WHEN Decision = 'S' THEN 1 ELSE 0 END) as saves,0 AS saves_opportunities, 0 as R, 0 AS HB, 0 AS HR, 0 AS BF, 0 AS cg, 0 as games")
      .order("YEAR(gameschedule.Game_Date) ASC").map { |row| PitchingStatsRow.from(row) }
  end

  def self.career_pitching_totals(player)
      stats = career_pitching_stats(player)
      get_pitching_totals(stats)
  end

  def self.season_pitching_stats(year, playoffs)
    pitching_stats_by_year = PitchingStat.joins(:gameschedule).joins(:player)
    .where(gameschedule: { Game_Date: Date.new(year).beginning_of_year..Date.new(year).end_of_year })
  if playoffs
    puts("Playoff value: #{playoffs}, outputting playoffs = true")
    pitching_stats_by_year = pitching_stats_by_year.where(gameschedule: { Playoff: true })
  else
    puts("Playoff value: #{playoffs}, outputting playoffs = false")
    pitching_stats_by_year = pitching_stats_by_year.where(gameschedule: { Playoff: false })
  end
  pitching_stats_by_year = pitching_stats_by_year
    .select("CONCAT_WS(', ', players.Last_Name, LEFT(players.First_Name, 1)) AS name, MIN(YEAR(gameschedule.Game_Date)) AS year, players.Player_ID, SUM(GS) AS GS,
    SUM(IP) AS IP, SUM(ER) AS ER, SUM(H) AS H, count(*) as games, SUM(R) as R, SUM(HB) as HB, SUM(HR) as HR, SUM(BF) as BF, SUM(cg) as cg,
      SUM(BB) AS BB, SUM(K) AS K, MIN(gameschedule.Game_ID) as Game_ID, MIN(Decision) as Decision,
      SUM(CASE WHEN Decision = 'W' or Decision = 'BS,W' THEN 1 ELSE 0 END) as wins,
SUM(CASE WHEN Decision = 'L' or Decision = 'BS,L' THEN 1 ELSE 0 END) as losses,
SUM(CASE WHEN Decision = 'S' THEN 1 ELSE 0 END) as saves,
SUM(CASE WHEN Decision = 'S' or Decision='BS,L' or Decision='BS,W' THEN 1 ELSE 0 END) as saves_opportunities")
    .group("players.Player_ID, players.Last_Name, players.First_Name")
    .order("SUM(IP) DESC")
    pitching_stats_by_year.map { |row| PitchingStatsRow.from(row) }
  end

  def self.season_pitching_totals(year, playoffs)
      stats = season_pitching_stats(year, playoffs)
      get_pitching_totals(stats)
  end

  def self.season_hitting_stats(year, playoffs)
    playoff_value = playoffs ? 1 :0
      sql = <<~SQL
    SELECT
      CONCAT_WS(', ', p.Last_Name, LEFT(p.First_Name, 1)) AS name,
      p.Player_ID,
      count(*) as games,
      SUM(AB) as ab,
      SUM(R) as r,
      SUM(H) as h,
      SUM(`2B`) as doubles,
      SUM(`3B`) AS triples,
      SUM(HR) AS hr,
      SUM(RBI) AS rbi,#{' '}
      SUM(BB) AS bb,#{' '}
      SUM(HBP) AS hbp,#{' '}
      SUM(K) AS k,#{' '}
      SUM(SB) AS sb,#{' '}
      SUM(CS) AS cs,#{' '}
      SUM(SAC) AS sac,#{' '}
      SUM(SF) AS sf,#{' '}
      SUM(LOB) AS lob
    FROM hittingstats hs
        JOIN gameschedule gs ON hs.Game_ID = gs.Game_ID
        JOIN players p ON hs.Player_ID = p.Player_ID
        WHERE gs.Game_Date BETWEEN '#{Date.new(year).beginning_of_year}' AND '#{Date.new(year).end_of_year}' AND gs.Playoff = #{playoff_value}
        GROUP BY p.Player_ID, p.Last_Name, p.First_Name
        ORDER BY ab DESC
  SQL
  stats = ActiveRecord::Base.connection.select_all(sql)
  stats.map { |row| HittingStatsRow.from(row) }
  end

  def self.season_hitting_totals(year, playoffs)
    stats = season_hitting_stats(year, playoffs)
    get_hitting_totals(stats)
  end

  def self.hitting_records
    sql = <<~SQL
      SELECT
        CONCAT_WS(', ', p.Last_Name, LEFT(p.First_Name, 1)) AS name,
        p.Player_ID,
        gs.playoff as playoff,
        YEAR(gs.Game_Date) as year,
        count(*) as games,
        SUM(AB) as ab,
        SUM(R) as r,
        SUM(H) as h,
        SUM(`2B`) as doubles,
        SUM(`3B`) AS triples,
        SUM(HR) AS hr,
        SUM(RBI) AS rbi,#{' '}
        SUM(BB) AS bb,#{' '}
        SUM(HBP) AS hbp,#{' '}
        SUM(K) AS k,#{' '}
        SUM(SB) AS sb,#{' '}
        SUM(CS) AS cs,#{' '}
        SUM(SAC) AS sac,#{' '}
        SUM(SF) AS sf,#{' '}
        SUM(LOB) AS lob
      FROM hittingstats hs
          JOIN gameschedule gs ON hs.Game_ID = gs.Game_ID
          JOIN players p ON hs.Player_ID = p.Player_ID
          GROUP BY p.Player_ID, p.Last_Name, p.First_Name,YEAR(Game_Date),playoff
          ORDER BY ab DESC
    SQL
    stats = ActiveRecord::Base.connection.select_all(sql)
    stats.map { |row| HittingStatsRow.from(row) }
  end
  def self.pitching_records
    pitching_stats_by_year = PitchingStat.joins(:gameschedule).joins(:player)
      .select("CONCAT_WS(', ', players.Last_Name, LEFT(players.First_Name, 1)) AS name, YEAR(gameschedule.Game_Date) AS year, gameschedule.Playoff as playoff,
        players.Player_ID, SUM(GS) AS GS, SUM(IP) AS IP, SUM(ER) AS ER, SUM(H) AS H, count(*) as games, SUM(R) as R, SUM(HB) as HB, SUM(HR) as HR, SUM(BF) as BF,
        SUM(cg) as cg, SUM(BB) AS BB, SUM(K) AS K, MIN(gameschedule.Game_ID) as Game_ID, MIN(Decision) as Decision,
        SUM(CASE WHEN Decision = 'W' or Decision = 'BS,W' THEN 1 ELSE 0 END) as wins,
        SUM(CASE WHEN Decision = 'L' or Decision = 'BS,L' THEN 1 ELSE 0 END) as losses,
        SUM(CASE WHEN Decision = 'S' THEN 1 ELSE 0 END) as saves,
        SUM(CASE WHEN Decision = 'S' or Decision='BS,L' or Decision='BS,W' THEN 1 ELSE 0 END) as saves_opportunities")
      .group("players.Player_ID, players.Last_Name, players.First_Name, gameschedule.playoff, YEAR(gameschedule.Game_Date)")
    pitching_stats_by_year.map { |row| PitchingStatsRow.from(row) }
  end
  def self.export(year, playoffs)
    puts(playoffs)
    pitching_stats = self.season_pitching_stats(year, playoffs)
    hitting_stats = self.season_hitting_stats(year, playoffs)
    puts(pitching_stats.count)
    puts(hitting_stats.count)
    puts("Year: #{year}, Playoffs: #{playoffs}")
    package = ::Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Stats") do |sheet|
      styles = workbook.styles
      header_style = styles.add_style(b: true, u: true, sz: 10, alignment: { horizontal: :center })
      first_header_style = styles.add_style(b: true, u: true, sz: 10, alignment: { horizontal: :left })
      stat_label_style = styles.add_style(b: true, sz: 12)
      two_decimal_style = styles.add_style(format_code: "0.00", alignment: { horizontal: :center })
      three_decimal_style = styles.add_style(format_code: ".000", alignment: { horizontal: :center })
      center_style = styles.add_style alignment: { horizontal: :center }

      # Header row
      sheet.add_row [ "Pitching Stats" ], style: stat_label_style
      row = sheet.add_row [ "Player", "W", "L", "S", "SVO", "G", "GS", "IP", "H", "R", "ER", "BB", "K", "HB", "HR", "BF", "CG", "ERA", "WHIP", "K/9", "BB/9" ],
        style: header_style
      row.cells[0].style = first_header_style
      pitching_stats.each do |stat|
        sheet.add_row [
          stat.name, stat.wins, stat.losses, stat.saves, stat.saves_opportunities, stat.games, stat.gs, stat.innings, stat.h, stat.r,
          stat.er, stat.bb, stat.k, stat.hb, stat.hr, stat.bf, stat.cg, stat.era, stat.whip, stat.k_per_nine, stat.bb_per_nine
        ], style: [ nil ] +  [ center_style ]  * 6 + [ two_decimal_style ] +  [ center_style ] * 9 +  [ two_decimal_style ] * 4
        end

        sheet.add_row []
        sheet.add_row [ "Hitting Stats" ], style: stat_label_style
        row = sheet.add_row [ "Player", "G", "AB", "R", "H", "2B", "3B", "HR", "RBI", "HBP", "K", "SB", "CS", "SAC", "SF", "LOB", "BA", "SLG", "OBP", "OPS" ],
          style: header_style
        row.cells[0].style = first_header_style
        hitting_stats.each do |stat|
          sheet.add_row [ stat.name, stat.games, stat.ab, stat.r, stat.h, stat.doubles, stat.triples, stat.hr, stat.rbi, stat.hbp, stat.k, stat.sb, stat.cs,
          stat.sac, stat.sf, stat.lob, stat.ba, stat.slg, stat.obp, stat.ops
        ], style: [ nil ] + [ center_style ] * 15 + [ three_decimal_style ] * 4
        end
        sheet.column_widths 15, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 10, 10, 10, 10
    end
    package
  end
  def self.get_pitching_totals(stats, name = "Totals")
    PitchingStatsRow.new(name: name, year: nil, player_id: nil, playoff: nil, decision: nil, games: stats.sum(&:games),
    gs: stats.sum(&:gs), ip: stats.sum(&:ip), er: stats.sum(&:er), h: stats.sum(&:h), r: stats.sum(&:r), hb: stats.sum(&:hb), hr: stats.sum(&:hr),
    bf: stats.sum(&:bf), cg: stats.sum(&:cg), bb: stats.sum(&:bb), k: stats.sum(&:k), wins: stats.sum(&:wins),
    losses: stats.sum(&:losses), saves: stats.sum(&:saves), saves_opportunities: stats.sum(&:saves_opportunities))
  end

  def self.get_hitting_totals(stats, name = "Totals")
    HittingStatsRow.new(name: name, year: nil, player_id: nil, playoff: nil, games: stats.sum(&:games), ab: stats.sum(&:ab),
    r: stats.sum(&:r), h: stats.sum(&:h), doubles: stats.sum(&:doubles), triples: stats.sum(&:triples),
    hr: stats.sum(&:hr), rbi: stats.sum(&:rbi), bb: stats.sum(&:bb), hbp: stats.sum(&:hbp), k: stats.sum(&:k),
    sb: stats.sum(&:sb), cs: stats.sum(&:cs), sac: stats.sum(&:sac), sf: stats.sum(&:sf), lob: stats.sum(&:lob))
  end
end
