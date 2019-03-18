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

ActiveRecord::Schema.define(version: 2019_03_18_223350) do

  create_table "border_countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.integer "border_country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_dbcc34e82e"
  end

  create_table "checkins", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "country_id"
    t.date "checkin_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_b90146f6c0"
    t.index ["user_id"], name: "index_checkins_on_user_id"
  end

  create_table "countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name_common"
    t.string "name_official"
    t.string "cca2"
    t.string "ccn3"
    t.string "cca3"
    t.string "cioc"
    t.string "capital"
    t.string "region"
    t.string "subregion"
    t.string "demonym"
    t.boolean "landlocked"
    t.float "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitude", precision: 10, default: "0"
    t.decimal "longitude", precision: 10, default: "0"
  end

  create_table "country_alternative_spellings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_4501639dad"
  end

  create_table "country_calling_codes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "calling_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_7d6ab3b33a"
  end

  create_table "country_languages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "code"
    t.index ["country_id"], name: "fk_rails_512239a8b1"
  end

  create_table "currencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_47700155d2"
  end

  create_table "top_level_domains", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_24af1ffde5"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.json "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "border_countries", "countries"
  add_foreign_key "checkins", "countries"
  add_foreign_key "checkins", "users"
  add_foreign_key "country_alternative_spellings", "countries"
  add_foreign_key "country_calling_codes", "countries"
  add_foreign_key "country_languages", "countries"
  add_foreign_key "currencies", "countries"
  add_foreign_key "top_level_domains", "countries"
end
