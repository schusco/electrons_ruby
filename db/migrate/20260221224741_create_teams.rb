class CreateTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams, id: false do |t|
      t.string :Team, null: false
      t.integer :W
      t.integer :L
      t.integer :T
      t.integer :F
      t.string :Division
      t.boolean :Active, default: true
      t.integer :Franchise_ID
    end
  end
end
