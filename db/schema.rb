# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150206173248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "suit"
    t.integer  "rank"
    t.integer  "player_id"
    t.boolean  "in_play",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "point_value"
    t.boolean  "lead",        default: false
  end

  add_index "cards", ["in_play"], name: "index_cards_on_in_play", using: :btree
  add_index "cards", ["lead"], name: "index_cards_on_lead", using: :btree
  add_index "cards", ["player_id"], name: "index_cards_on_player_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "turn",       default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "player_num"
    t.integer  "score",      default: 0
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_score", default: 0
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree
  add_index "players", ["player_num"], name: "index_players_on_player_num", using: :btree
  add_index "players", ["score"], name: "index_players_on_score", using: :btree

end
