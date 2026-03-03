class CreateSeasonTwoView < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
          CREATE VIEW `Season2`  AS SELECT `g`.`Game_ID` AS `game_id`, (case when (((`gw`.`Hruns` > `gw`.`Aruns`) and (`g`.`HV` = 'H')) or ((`gw`.`Aruns` > `gw`.`Hruns`) and (`g`.`HV` = 'V'))) then 1 else 0 end) AS `W`, (case when (((`gw`.`Hruns` < `gw`.`Aruns`) and (`g`.`HV` = 'H')) or ((`gw`.`Aruns` < `gw`.`Hruns`) and (`g`.`HV` = 'V'))) then 1 else 0 end) AS `L`, (case when ((`gw`.`Hruns` = `gw`.`Aruns`) and (`gw`.`Hruns` > 0) and (`gw`.`Aruns` > 0)) then 1 else 0 end) AS `T` FROM (`gameschedule` `g` join `Season1` `gw` on((`gw`.`GameId` = `g`.`Game_ID`))) WHERE (year(`g`.`Game_Date`) > 2005) ;
    SQL
  end
  def down
    drop_view :Season2, materialized: true
  end
end
