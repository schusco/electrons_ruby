class AddPlayerToAwards < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :awards, :players, column: "Player_ID", primary_key: "Player_ID", on_delete: :cascade
    add_index :awards, :Player_ID unless index_exists?(:awards, :Player_ID)
  end
end
