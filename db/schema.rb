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

ActiveRecord::Schema[8.0].define(version: 2025_07_23_133216) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "likes", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "architect_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["architect_id"], name: "index_likes_on_architect_id"
    t.index ["client_id", "architect_id"], name: "index_likes_on_client_id_and_architect_id", unique: true
    t.index ["client_id"], name: "index_likes_on_client_id"
  end

  create_table "multimedias", force: :cascade do |t|
    t.integer "project_id"
    t.string "type_media"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_multimedias_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "architect_id", null: false
    t.string "title"
    t.boolean "portfolio", default: false
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
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "architect_specializations", "architects", on_delete: :cascade
  add_foreign_key "architect_specializations", "specializations", on_delete: :cascade
  add_foreign_key "architects", "users", on_delete: :cascade
  add_foreign_key "cities", "users"
  add_foreign_key "likes", "architects"
  add_foreign_key "likes", "users", column: "client_id"
  add_foreign_key "multimedias", "projects", on_delete: :cascade
  add_foreign_key "projects", "architects", on_delete: :cascade
  add_foreign_key "projects", "users", on_delete: :cascade
end
