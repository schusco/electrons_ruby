class AddForeignKeysToGameSchedule < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :gameschedule, :players, column: :"Manager", primary_key: :"Player_ID", on_update: :cascade
    add_foreign_key :gameschedule, :locations, column: :"LocationId", primary_key: :"Id"
    add_index :gameschedule, :Manager
    add_index :gameschedule, :LocationId
  end
end
