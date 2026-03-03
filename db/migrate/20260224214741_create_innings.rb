class CreateInnings < ActiveRecord::Migration[8.1]
  def change
    create_table :innings, id: false do |t|
      t.integer :GameId
      t.integer :Inning
      t.integer :Hruns
      t.integer :Hhits
      t.integer :Herrors
      t.integer :Aruns
      t.integer :Ahits
      t.integer :Aerrors
    end
    execute "ALTER TABLE innings ADD PRIMARY KEY (GameId, Inning);"
  end
end
