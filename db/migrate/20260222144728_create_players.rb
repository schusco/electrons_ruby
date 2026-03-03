class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players, id: false do |t|
      t.integer :Player_ID, null: false, primary_key: true
      t.string :First_Name
      t.string :Last_Name
      t.boolean :Current
      t.string :Bats
      t.string :Throws
      t.string :POS1
      t.string :POS2
      t.string :POS3
      t.string :Nickname
      t.string :Hometown
      t.integer :Divorces
      t.datetime :DOB
      t.integer :Height
      t.integer :Weight
      t.boolean :Image
      t.integer :uniform
      t.string :email
    end
  end
end
