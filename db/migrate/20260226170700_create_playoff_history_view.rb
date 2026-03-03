class CreatePlayoffHistoryView < ActiveRecord::Migration[6.0]
  def up
    execute <<~SQL
      CREATE VIEW `PlayoffHistory`  AS SELECT `history`.`YearStart` AS `Year`, concat_ws('-',coalesce(`SeasonRecords`.`W`,0),coalesce(`SeasonRecords`.`L`,0)) AS `Record`, `history`.`Finish` AS `Result`, coalesce(`SeasonRecords`.`W`,0) AS `W`, coalesce(`SeasonRecords`.`L`,0) AS `L` FROM (`history` left join `SeasonRecords` on(((`SeasonRecords`.`Year` = `history`.`YearStart`) and (`SeasonRecords`.`Playoff` = 1)))) WHERE (`history`.`Category` = 'Championship') ORDER BY `history`.`YearStart` ASC ;
    SQL
  end
  def down
    drop_table :PlayoffHistory, materialized: true
  end
end
