class CreateDepthCharts < ActiveRecord::Migration[8.1]
  def change
    create_table :dc do |t|
      t.integer :Position
      t.integer :Rank
      t.integer :Player
    end
  end
end
