# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_18_145605) do

  create_table "announcements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

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
    t.boolean "landlocked"
    t.float "area"
    t.string "demonym"
    t.boolean "independent"
    t.string "status", limit: 50
    t.string "flag"
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
    t.string "name", limit: 100
    t.string "symbol", limit: 15
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "fk_rails_47700155d2"
  end

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "recipient_id", null: false
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.datetime "read_at"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
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
    t.string "jti_token", null: false
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
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti_token"], name: "index_users_on_jti_token", unique: true
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
