class CreateGameschedules < ActiveRecord::Migration[8.1]
  def change
    create_table :gameschedule do |t|
      t.datetime :Game_Date
      t.string :Opponent, limit: 25, null: false
      t.string :HV, null: false, default: "H"
      t.string :Location, limit: 20, null: false
      t.boolean :Playoff, null: false, default: false
      t.boolean :Finals, null: false, default: false
      t.boolean :Wood, null: false, default: false
      t.integer :Manager, null: false, default: 0
      t.integer :SP, null: false, default: 0
      t.string :Notes, limit: 145
      t.integer :LocationId, unsigned: true, null: false
      t.text :GameFile, limit: 16.megabytes - 1
    end
      add_index :gameschedule, :gamedate, unique: true
  end
end
