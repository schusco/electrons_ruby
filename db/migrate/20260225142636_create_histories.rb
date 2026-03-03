class CreateHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :history do |t|
      t.string :Category
      t.string :Data
      t.string :YearStart
      t.string :YearEnd
      t.string :Finish
    end
  end
end
