class HelloWorld < ActiveRecord::Migration[7.0]
  def change
    create_table "vote_category", force: :cascade do |t|
      t.string "name"

      t.timestamps
    end

    create_table "candidates", force: :cascade do |t|
      t.string "code"
      t.integer "votes", default: 0
      t.bigint "year_id"
      t.bigint "vote_category"
      t.integer "number"
      t.index ["year_id"], name: "index_candidates_on_year_id"
      t.index ["vote_category"], name: "index_candidates_on_vote_category_id"

      t.timestamps
    end

    create_table "contacts", force: :cascade do |t|
      t.string "fullname"
      t.string "email"
      t.text "message"
      
      t.timestamps
    end

    create_table "daily_votes", force: :cascade do |t|
      t.date "day_date"
      t.integer "votes", default: 0

      t.timestamps
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
      t.index ["region_id"], name: "index_inscriptions_on_region_id"
      t.index ["year_id"], name: "index_inscriptions_on_year_id"

      t.timestamps
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

      t.timestamps
    end

    create_table "regions", force: :cascade do |t|
      t.string "name"

      t.timestamps
    end

    create_table "settings", force: :cascade do |t|
      t.boolean "vote", default: false
      t.boolean "show_candidate_section", default: false
      
      t.timestamps
    end

    create_table "voters", force: :cascade do |t|
      t.string "phone"
      t.integer "current_flow_step", default: 0
      t.datetime "voted_at"
      t.bigint "candidate_id"
      t.bigint "payment_id"
      t.index ["candidate_id"], name: "index_voters_on_candidate_id"
      t.index ["payment_id"], name: "index_voters_on_payment_id"

      t.timestamps
    end

    create_table "years", force: :cascade do |t|
      t.integer "name"
      t.boolean "current_year", default: false

      t.timestamps
    end
  end
end
