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

ActiveRecord::Schema.define(version: 2020_04_22_163049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodyparts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_bodyparts", force: :cascade do |t|
    t.bigint "exercise_id"
    t.bigint "bodypart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bodypart_id"], name: "index_exercise_bodyparts_on_bodypart_id"
    t.index ["exercise_id"], name: "index_exercise_bodyparts_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.boolean "unilateral"
    t.boolean "machine", default: false
    t.boolean "bodyweight", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "force_bilateral"
    t.text "info"
    t.float "m_mech_ad_override"
    t.float "f_mech_ad_override"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name"
    t.float "mech_ad"
    t.integer "pulley_count"
    t.integer "inherit_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_machines_on_brand_id"
    t.index ["name", "brand_id"], name: "index_machines_on_name_and_brand_id", unique: true
  end

  create_table "resistance_methods", force: :cascade do |t|
    t.string "name"
    t.string "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "unilateral"
    t.boolean "bodyweight"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "session_sets", force: :cascade do |t|
    t.integer "weight"
    t.integer "reps"
    t.bigint "training_session_id"
    t.bigint "exercise_id"
    t.bigint "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pulley_count", default: 1
    t.bigint "resistance_method_id"
    t.index ["exercise_id"], name: "index_session_sets_on_exercise_id"
    t.index ["machine_id"], name: "index_session_sets_on_machine_id"
    t.index ["resistance_method_id"], name: "index_session_sets_on_resistance_method_id"
    t.index ["training_session_id"], name: "index_session_sets_on_training_session_id"
  end

  create_table "session_strategies", force: :cascade do |t|
    t.string "name"
    t.text "description", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_sessions", force: :cascade do |t|
    t.integer "session_number"
    t.boolean "open", default: true
    t.bigint "session_strategy_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["session_strategy_id"], name: "index_training_sessions_on_session_strategy_id"
    t.index ["user_id"], name: "index_training_sessions_on_user_id"
  end

  create_table "user_weights", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_weights_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.boolean "active", default: false
    t.bigint "role_id", default: 12
    t.bigint "gender_id"
    t.string "units_of_measure"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["gender_id"], name: "index_users_on_gender_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "exercise_bodyparts", "bodyparts"
  add_foreign_key "exercise_bodyparts", "exercises"
  add_foreign_key "session_sets", "exercises"
  add_foreign_key "session_sets", "machines"
  add_foreign_key "session_sets", "resistance_methods"
  add_foreign_key "session_sets", "training_sessions"
  add_foreign_key "training_sessions", "session_strategies"
  add_foreign_key "training_sessions", "users"
  add_foreign_key "user_weights", "users"
  add_foreign_key "users", "genders"
  add_foreign_key "users", "roles"
end
