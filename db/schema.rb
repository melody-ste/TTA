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

ActiveRecord::Schema[8.0].define(version: 2025_07_16_102451) do
  create_table "architect_specializations", force: :cascade do |t|
    t.integer "architect_id", null: false
    t.integer "specialization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["architect_id"], name: "index_architect_specializations_on_architect_id"
    t.index ["specialization_id"], name: "index_architect_specializations_on_specialization_id"
  end

  create_table "architects", force: :cascade do |t|
    t.text "description"
    t.string "degree_name"
    t.string "degree_acronym"
    t.integer "years_study"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_architects_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "zip_code"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cities_on_user_id"
  end

  create_table "multimedias", force: :cascade do |t|
    t.integer "portfolio_id", null: false
    t.string "type_media"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portfolio_id"], name: "index_multimedias_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "architect_id", null: false
    t.string "project_title"
    t.text "project_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["architect_id"], name: "index_portfolios_on_architect_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "architect_id", null: false
    t.date "start_date"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["architect_id"], name: "index_projects_on_architect_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "architect_specializations", "architects"
  add_foreign_key "architect_specializations", "specializations"
  add_foreign_key "architects", "users"
  add_foreign_key "cities", "users"
  add_foreign_key "multimedias", "portfolios"
  add_foreign_key "portfolios", "architects"
  add_foreign_key "projects", "architects"
  add_foreign_key "projects", "users"
end
