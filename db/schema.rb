# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_05_194801) do
  create_table "awards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Player_id"
    t.string "award"
    t.index ["Player_id"], name: "index_awards_on_Player_ID"
  end

  create_table "dc", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Player"
    t.integer "Position"
    t.integer "Rank"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date"
    t.text "event"
  end

  create_table "gameschedule", primary_key: "Game_ID", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "Finals", default: false, null: false
    t.text "GameFile", size: :medium
    t.datetime "Game_Date"
    t.string "HV", default: "H", null: false
    t.string "Location", limit: 20, null: false
    t.integer "LocationId", null: false, unsigned: true
    t.integer "Manager", default: 0, null: false
    t.string "Notes", limit: 145
    t.string "Opponent", limit: 25, null: false
    t.boolean "Playoff", default: false, null: false
    t.integer "SP", default: 0, null: false
    t.boolean "Wood", default: false, null: false
    t.index ["Game_Date"], name: "index_gameschedules_on_gamedate", unique: true
    t.index ["LocationId"], name: "index_gameschedule_on_LocationId"
    t.index ["Manager"], name: "index_gameschedule_on_Manager"
  end

  create_table "history", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "Category"
    t.string "Data"
    t.string "Finish"
    t.string "YearEnd"
    t.string "YearStart"
  end

  create_table "hittingstats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "2B"
    t.integer "3B"
    t.integer "A"
    t.integer "AB"
    t.integer "BB"
    t.integer "Bitching"
    t.integer "CS"
    t.integer "E"
    t.bigint "Game_ID"
    t.integer "H"
    t.integer "HBP"
    t.integer "HR"
    t.integer "K"
    t.integer "LOB"
    t.integer "PO"
    t.integer "Player_ID"
    t.integer "R"
    t.integer "RBI"
    t.integer "SAC"
    t.integer "SB"
    t.integer "SF"
    t.index ["Game_ID"], name: "fk_rails_07763d2699"
    t.index ["Player_ID"], name: "fk_rails_925ad0b6c9"
  end

  create_table "innings", primary_key: ["GameId", "Inning"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Aerrors"
    t.integer "Ahits"
    t.integer "Aruns"
    t.integer "GameId", null: false
    t.integer "Herrors"
    t.integer "Hhits"
    t.integer "Hruns"
    t.integer "Inning", null: false
  end

  create_table "locations", primary_key: "Id", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "CityAndState", limit: 45
    t.boolean "Current", null: false
    t.string "FieldName", limit: 45, null: false
    t.string "GoogleName", limit: 100, null: false
    t.string "Link", null: false
    t.string "ShortName", limit: 2, null: false
  end

  create_table "notable_players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date"
    t.text "first_name"
    t.text "last_name"
  end

  create_table "pitchingstats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "BB"
    t.integer "BF"
    t.string "Decision"
    t.integer "ER"
    t.integer "GS"
    t.bigint "Game_ID"
    t.integer "H"
    t.integer "HB"
    t.integer "HR"
    t.float "IP"
    t.integer "K"
    t.integer "Player_ID"
    t.integer "R"
    t.integer "cg"
    t.index ["Game_ID"], name: "fk_rails_00ba5d58c5"
    t.index ["Player_ID"], name: "fk_rails_23f7e1e20f"
  end

  create_table "players", primary_key: "Player_ID", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "Bats"
    t.boolean "Current"
    t.datetime "DOB"
    t.integer "Divorces"
    t.string "First_Name"
    t.integer "Height"
    t.string "Hometown"
    t.boolean "Image"
    t.string "Last_Name"
    t.string "Nickname"
    t.string "POS1"
    t.string "POS2"
    t.string "POS3"
    t.string "Throws"
    t.integer "Weight"
    t.string "email"
    t.integer "uniform"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "Active", default: true
    t.string "Division"
    t.integer "F"
    t.integer "Franchise_ID"
    t.integer "L"
    t.integer "T"
    t.string "Team", null: false
    t.integer "W"
  end

  add_foreign_key "awards", "players", column: "Player_id", primary_key: "Player_ID", on_delete: :cascade
  add_foreign_key "gameschedule", "locations", column: "LocationId", primary_key: "Id"
  add_foreign_key "gameschedule", "players", column: "Manager", primary_key: "Player_ID", on_update: :cascade
  add_foreign_key "hittingstats", "gameschedule", column: "Game_ID", primary_key: "Game_ID"
  add_foreign_key "hittingstats", "players", column: "Player_ID", primary_key: "Player_ID"
  add_foreign_key "pitchingstats", "gameschedule", column: "Game_ID", primary_key: "Game_ID"
  add_foreign_key "pitchingstats", "players", column: "Player_ID", primary_key: "Player_ID"
end
