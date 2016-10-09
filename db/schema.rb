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

ActiveRecord::Schema.define(version: 20161009154204) do

  create_table "checkins", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "country_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "checkin_date"
  end

  add_index "checkins", ["country_id"], name: "fk_rails_b90146f6c0", using: :btree
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name_common",   limit: 255
    t.string   "name_official", limit: 255
    t.string   "cca2",          limit: 255
    t.string   "ccn3",          limit: 255
    t.string   "cca3",          limit: 255
    t.string   "cioc",          limit: 255
    t.string   "capital",       limit: 255
    t.string   "region",        limit: 255
    t.string   "subregion",     limit: 255
    t.string   "latlang",       limit: 255
    t.string   "demonym",       limit: 255
    t.boolean  "landlocked"
    t.float    "area",          limit: 24
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.decimal  "latitude",                  precision: 10, default: 0
    t.decimal  "longitude",                 precision: 10, default: 0
  end

  create_table "country_alternative_spellings", force: :cascade do |t|
    t.integer  "country_id", limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "country_alternative_spellings", ["country_id"], name: "fk_rails_4501639dad", using: :btree

  create_table "country_borders", force: :cascade do |t|
    t.integer  "country_id",        limit: 4
    t.integer  "border_country_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "country_borders", ["country_id"], name: "fk_rails_dbcc34e82e", using: :btree

  create_table "country_calling_codes", force: :cascade do |t|
    t.integer  "country_id",   limit: 4
    t.string   "calling_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "country_calling_codes", ["country_id"], name: "fk_rails_7d6ab3b33a", using: :btree

  create_table "country_languages", force: :cascade do |t|
    t.integer  "country_id", limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",       limit: 255
  end

  add_index "country_languages", ["country_id"], name: "fk_rails_512239a8b1", using: :btree

  create_table "currencies", force: :cascade do |t|
    t.integer  "country_id", limit: 4
    t.string   "code",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "currencies", ["country_id"], name: "fk_rails_47700155d2", using: :btree

  create_table "top_level_domains", force: :cascade do |t|
    t.integer  "country_id", limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "top_level_domains", ["country_id"], name: "fk_rails_24af1ffde5", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "checkins", "countries"
  add_foreign_key "checkins", "users"
  add_foreign_key "country_alternative_spellings", "countries"
  add_foreign_key "country_borders", "countries"
  add_foreign_key "country_calling_codes", "countries"
  add_foreign_key "country_languages", "countries"
  add_foreign_key "currencies", "countries"
  add_foreign_key "top_level_domains", "countries"
end
