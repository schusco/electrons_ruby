class HistoryReportService
  def self.playoff_records
    sql = <<~SQL
    SELECT concat_ws(' ',players.First_Name,players.Last_Name) as Manager,cast(Concat_ws('-',SUM(W) ,SUM(L)) as char(10)) as record
        from Season2 join gameschedule on gameschedule.Game_ID = Season2.game_id
        join history on history.YearStart = year(gameschedule.Game_Date) and history.Category = 'Manage'
        join players on players.Player_ID = history.Data where gameschedule.Playoff = 1
        group by history.Data
        union select 'Total',cast(Concat_ws('-',SUM(W) ,SUM(L)) as char(10))
        from Season2 join gameschedule on gameschedule.Game_ID = Season2.game_id
        join history on history.YearStart = year(gameschedule.Game_Date) and history.Category = 'Manage'
        join players on players.Player_ID = history.Data where gameschedule.Playoff = 1
    SQL
    ActiveRecord::Base.connection.select_all(sql)
  end

  def self.current_season_record
    SeasonRecord.current
  end
end
