class CreateNotablePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :notable_players do |t|
      t.text :last_name
      t.text :first_name
      t.datetime :date
    end
  end
end
