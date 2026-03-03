class CreateSeasonOneView < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
          CREATE VIEW `Season1`  AS SELECT `Innings`.`GameId` AS `GameId`, `gameschedule`.`HV` AS `HV`, sum(`Innings`.`Hruns`) AS `Hruns`, sum(`Innings`.`Aruns`) AS `Aruns`, sum(`Innings`.`Hhits`) AS `HHits`, sum(`Innings`.`Ahits`) AS `AHits`, sum(`Innings`.`Herrors`) AS `HErrors`, sum(`Innings`.`Aerrors`) AS `AErrors` FROM (`Innings` join `gameschedule` on((`gameschedule`.`Game_ID` = `Innings`.`GameId`))) GROUP BY `Innings`.`GameId`, `gameschedule`.`HV` ;
    SQL
  end
  def down
    drop_view :Season1, materialized: true
  end
end
