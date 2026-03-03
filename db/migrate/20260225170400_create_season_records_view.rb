class CreateSeasonRecordsView < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
          CREATE VIEW `SeasonRecords`  AS SELECT 0 AS `Playoff`, 2003 AS `Year`, 7 AS `W`, 21 AS `L`, 0 AS `T`union select 0 AS `0`,2004 AS `2004`,2 AS `2`,25 AS `25`,0 AS `0` union select 0 AS `0`,2005 AS `2005`,7 AS `7`,20 AS `20`,0 AS `0` union select `gs`.`Playoff` AS `Season`,year(`gs`.`Game_Date`) AS `YEAR(gs.Game_Date)`,sum(`record`.`W`) AS `W`,sum(`record`.`L`) AS `L`,sum(`record`.`T`) AS `T` from (`gameschedule` `gs` join `Season2` `record` on((`gs`.`Game_ID` = `record`.`game_id`))) group by year(`gs`.`Game_Date`),`gs`.`Playoff`  ;
    SQL
  end
  def down
    drop_view :SeasonRecords, materialized: true
  end
end
