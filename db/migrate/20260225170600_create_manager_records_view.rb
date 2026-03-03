class CreateManagerRecordsView < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
          CREATE VIEW `ManagerRecords`  AS SELECT concat_ws(' ',`players`.`First_Name`,`players`.`Last_Name`) AS `Manager`, concat_ws('-',min(`history`.`YearStart`),(case when (max(`history`.`YearStart`) >= year(curdate())) then 'Present' else max(`history`.`YearStart`) end)) AS `Years`, count(distinct `history`.`YearStart`) AS `Seasons`, concat_ws('-',sum(coalesce(`SeasonRecords`.`W`,0)),sum(coalesce(`SeasonRecords`.`L`,0)),sum(coalesce(`SeasonRecords`.`T`,0))) AS `Record`, ((sum(coalesce(`SeasonRecords`.`W`,0)) + sum(coalesce(`SeasonRecords`.`L`,0))) + sum(coalesce(`SeasonRecords`.`T`,0))) AS `Games` FROM ((`players` join `history` on(((`history`.`Data` = `players`.`Player_ID`) and (`history`.`Category` = 'Manage')))) left join `SeasonRecords` on((`SeasonRecords`.`Year` = `history`.`YearStart`))) GROUP BY `history`.`Data`union select 'Total' AS `Total`,concat_ws('-',min(`history`.`YearStart`),max(`history`.`YearStart`)) AS `Years`,count(distinct `SeasonRecords`.`Year`) AS `Seasons`,concat_ws('-',sum(`SeasonRecords`.`W`),sum(`SeasonRecords`.`L`),sum(`SeasonRecords`.`T`)) AS `Record`,((sum(`SeasonRecords`.`W`) + sum(`SeasonRecords`.`L`)) + sum(`SeasonRecords`.`T`)) AS `Games` from (`history` join `SeasonRecords` on(((`SeasonRecords`.`Year` = `history`.`YearStart`) and (`history`.`Category` = 'Manage'))))  ;
    SQL
  end
  def down
    drop_view :ManagerRecords, materialized: true
  end
end
