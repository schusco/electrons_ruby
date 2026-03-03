class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations, primary_key: "Id", id: :integer, unsigned: true do |t|
    t.string  :FieldName,    limit: 45,  null: false
    t.string  :ShortName,    limit: 2,   null: false
    t.string  :Link,         limit: 255, null: false
    t.boolean :Current,                 null: false
    t.string  :CityAndState, limit: 45
    t.string  :GoogleName,   limit: 100, null: false
    end
  end
end
