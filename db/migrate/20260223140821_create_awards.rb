class CreateAwards < ActiveRecord::Migration[8.1]
  def change
    create_table :awards do |t|
      t.integer :Player_id
      t.string :award
    end
  end
end
