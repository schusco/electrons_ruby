class CreatePitchingStats < ActiveRecord::Migration[8.1]
  def change
    create_table :pitchingstats do |t|
      t.integer :Player_ID
      t.bigint :Game_ID
      t.string :Decision
      t.integer :GS
      t.float :IP
      t.integer :BF
      t.integer :H
      t.integer :R
      t.integer :ER
      t.integer :BB
      t.integer :K
      t.integer :HB
      t.integer :HR
      t.integer :cg
    end

      add_foreign_key :pitchingstats, :players, column: :Player_ID, primary_key: :Player_ID
      add_foreign_key :pitchingstats, :gameschedules, column: :Game_ID, primary_key: :Game_ID
  end
end
