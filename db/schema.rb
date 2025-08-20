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

ActiveRecord::Schema[7.0].define(version: 2025_06_28_181111) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "candidate_categories", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_candidate_categories_on_candidate_id"
    t.index ["category_id"], name: "index_candidate_categories_on_category_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "code"
    t.integer "votes", default: 0
    t.bigint "year_id"
    t.bigint "vote_category"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "category_rank"
    t.string "vote_code"
    t.string "name"
    t.index ["vote_category"], name: "index_candidates_on_vote_category_id"
    t.index ["year_id"], name: "index_candidates_on_year_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_votes", force: :cascade do |t|
    t.date "day_date"
    t.integer "votes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscriptions", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_whatsapps"
    t.string "weigth"
    t.string "profession"
    t.integer "studying_level"
    t.string "email"
    t.text "address"
    t.integer "status"
    t.bigint "region_id"
    t.jsonb "data"
    t.boolean "payment_confirmed", default: false
    t.string "payment_uid"
    t.integer "age"
    t.integer "height"
    t.text "facebook_url"
    t.text "linkedin_url"
    t.text "instagram_url"
    t.text "tiktok_url"
    t.boolean "inscription_fee", default: false
    t.datetime "deleted_at"
    t.boolean "approved", default: false
    t.bigint "year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_inscriptions_on_region_id"
    t.index ["year_id"], name: "index_inscriptions_on_year_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.integer "status"
    t.string "payment_phone"
    t.datetime "validated_at"
    t.string "order_id"
    t.jsonb "metadata"
    t.string "payment_uid"
    t.integer "provider", default: 0
    t.string "public_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.boolean "vote", default: false
    t.boolean "show_candidate_section", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "show_countdown"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "profile"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vote_category", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voters", force: :cascade do |t|
    t.string "phone"
    t.integer "current_flow_step", default: 0
    t.datetime "voted_at"
    t.bigint "candidate_id"
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_voters_on_candidate_id"
    t.index ["payment_id"], name: "index_voters_on_payment_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "name"
    t.boolean "current_year", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidate_categories", "candidates"
  add_foreign_key "candidate_categories", "categories"
end
