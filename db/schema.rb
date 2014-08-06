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

ActiveRecord::Schema.define(version: 20140806115505) do

  create_table "authors", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title",                null: false
    t.integer  "author_id",            null: false
    t.integer  "publisher_id",         null: false
    t.string   "isbn",                 null: false
    t.string   "pages",                null: false
    t.integer  "genre_id",             null: false
    t.integer  "print_nr",             null: false
    t.integer  "print_year",           null: false
    t.integer  "language_id",          null: false
    t.integer  "original_language_id", null: false
    t.integer  "serie_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "serie_nr"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["genre_id"], name: "index_books_on_genre_id", using: :btree
  add_index "books", ["language_id"], name: "index_books_on_language_id", using: :btree
  add_index "books", ["original_language_id"], name: "index_books_on_original_language_id", using: :btree
  add_index "books", ["publisher_id"], name: "index_books_on_publisher_id", using: :btree
  add_index "books", ["serie_id"], name: "index_books_on_serie_id", using: :btree

  create_table "bread_logs", force: true do |t|
    t.integer  "cat_id",                             null: false
    t.integer  "event_date",                         null: false
    t.decimal  "price",      precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: true do |t|
    t.string   "name",       null: false
    t.string   "colour",     null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wage"
  end

  add_index "designations", ["user_id"], name: "index_designations_on_user_id", using: :btree

  create_table "genres", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.decimal  "price",       precision: 4, scale: 2
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                             default: true
  end

  create_table "languages", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iso"
  end

  create_table "news_feeds", force: true do |t|
    t.text     "text",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.boolean  "paid",                          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "history",      limit: 16777215
    t.string   "order"
    t.integer  "saturday_int"
  end

  create_table "publishers", force: true do |t|
    t.string   "name",       null: false
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", force: true do |t|
    t.string   "seq",        null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sequences", ["user_id"], name: "index_sequences_on_user_id", using: :btree

  create_table "series", force: true do |t|
    t.string   "name",       null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "series", ["author_id"], name: "index_series_on_author_id", using: :btree

  create_table "statics", force: true do |t|
    t.string   "identifier", null: false
    t.text     "text",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_rights", force: true do |t|
    t.integer  "user_id"
    t.string   "rights_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "path"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.text     "pref",       limit: 16777215
    t.string   "type"
  end

  create_table "weekly_orders", force: true do |t|
    t.integer  "user_id"
    t.string   "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workdays", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "day",            null: false
    t.integer  "designation_id", null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workdays", ["day"], name: "index_workdays_on_day", using: :btree
  add_index "workdays", ["user_id"], name: "index_workdays_on_user_id", using: :btree

end
