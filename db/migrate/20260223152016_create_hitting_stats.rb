class CreateHittingStats < ActiveRecord::Migration[8.1]
  def change
    create_table :hittingstats do |t|
      t.integer :Player_ID
      t.bigint :Game_ID
      t.integer :AB
      t.integer :R
      t.integer :H
      t.integer :"2B"
      t.integer :"3B"
      t.integer :HR
      t.integer :RBI
      t.integer :BB
      t.integer :HBP
      t.integer :K
      t.integer :SB
      t.integer :CS
      t.integer :SAC
      t.integer :SF
      t.integer :LOB
      t.integer :Bitching
      t.integer :PO
      t.integer :A
      t.integer :E
    end

      add_foreign_key :hittingstats, :players, column: :Player_ID, primary_key: :Player_ID
      add_foreign_key :hittingstats, :gameschedules, column: :Game_ID, primary_key: :Game_ID
  end
end
