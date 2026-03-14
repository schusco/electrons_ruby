HittingStatsRow = Data.define(:name, :year, :games, :ab, :r, :h, :doubles, :triples, :hr, :rbi, :bb, :hbp, :k, :sb, :cs, :sac, :sf, :lob, :player_id, :playoff, :number) do
  def ba
    return 0 if ab.zero?
    format_stat(h.to_f / ab)
  end
  def obp
    obp_val = obp_decimal
    format_stat(obp_val)
  end
  def slg
    slg_val= slugging_decimal
    format_stat(slg_val)
  end
  def ops
    format_stat(obp_decimal + slugging_decimal)
  end
  def self.from(source)
    if source.is_a?(Hash)
      new(
        source["name"],
        source["year"],
        source["games"].to_i,
        source["ab"].to_i,
        source["r"].to_i,
        source["h"].to_i,
        source["doubles"].to_i,
        source["triples"].to_i,
        source["hr"].to_i,
        source["rbi"].to_i,
        source["bb"].to_i,
        source["hbp"].to_i,
        source["k"].to_i,
        source["sb"].to_i,
        source["cs"].to_i,
        source["sac"].to_i,
        source["sf"].to_i,
        source["lob"].to_i,
        source["Player_ID"],
        source["playoff"],
        source["number"]
      )
    else
      new(
        source.player.short_name,
        source.gameschedule.Game_Date.year,
        source.games.to_i,
        source.at_bats.to_i,
        source.runs.to_i,
        source.hits.to_i,
        source.doubles.to_i,
        source.triples.to_i,
        source.home_runs.to_i,
        source.runs_batted_in.to_i,
        source.walks.to_i,
        source.hit_by_pitch.to_i,
        source.strikeouts.to_i,
        source.stolen_bases.to_i,
        source.caught_stealing.to_i,
        source.sacrifice_bunts.to_f,
        source.sacrifice_flies.to_i,
        source.left_on_base.to_i,
        source.Player_ID,
        source.gameschedule.Playoff,
        source.player.uniform
      )
    end
  end
  def format_stat(value)
    return ".000" if value.blank? || value.zero?

    # 1. Format to 3 decimal places using sprintf
    formatted = sprintf("%.3f", value)

    # 2. Remove the leading zero using sub
    formatted.sub(/^0/, "")
  end

  private

    def slugging_decimal
      return 0 if ab.to_i.zero?
      total_bases = h + doubles + (2 * triples) + (3 * hr)
      total_bases.to_f / ab.to_i
    end
    def obp_decimal
      plate_appearances = ab.to_i + bb + hbp
      return 0 if plate_appearances.zero?
      (h + bb + hbp).to_f / plate_appearances
    end
end
