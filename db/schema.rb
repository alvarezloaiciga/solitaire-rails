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

ActiveRecord::Schema.define(version: 20140403160404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.string  "name"
    t.string  "suit"
    t.integer "value"
  end

  create_table "cards_cards_trains", force: true do |t|
    t.integer "card_id"
    t.integer "cards_train_id"
  end

  create_table "cards_feeder_line_columns", force: true do |t|
    t.integer "card_id"
    t.integer "feeder_line_column_id"
    t.integer "position"
  end

  create_table "cards_product_line_columns", force: true do |t|
    t.integer "card_id"
    t.integer "product_line_column_id"
    t.integer "position"
  end

  create_table "cards_trains", force: true do |t|
    t.integer "solitaire_game_id"
    t.integer "active_card_position"
  end

  create_table "feeder_line_columns", force: true do |t|
    t.integer "feeder_line_id"
    t.integer "number"
    t.integer "first_active_card_position"
  end

  add_index "feeder_line_columns", ["feeder_line_id"], name: "index_feeder_line_columns_on_feeder_line_id", using: :btree

  create_table "feeder_lines", force: true do |t|
    t.integer "solitaire_game_id"
  end

  create_table "product_line_columns", force: true do |t|
    t.integer "product_line_id"
    t.integer "number"
    t.integer "active_card_position"
  end

  add_index "product_line_columns", ["product_line_id"], name: "index_product_line_columns_on_product_line_id", using: :btree

  create_table "product_lines", force: true do |t|
    t.integer "solitaire_game_id"
  end

  create_table "solitaire_games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
