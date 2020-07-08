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

ActiveRecord::Schema.define(version: 2020_07_07_041524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "user_id_id"
    t.string "public_id"
    t.string "box_width"
    t.string "box_height"
    t.string "box_left"
    t.string "box_top"
    t.integer "age_low"
    t.integer "age_high"
    t.string "eyeglasses"
    t.string "eyeglass_con"
    t.string "gender"
    t.string "gender_con"
    t.string "beard"
    t.string "beard_con"
    t.string "mustache"
    t.string "mustache_con"
    t.string "eyeLeft"
    t.string "eyeRight"
    t.string "mouthLeft"
    t.string "mouthRight"
    t.string "nose"
    t.string "leftEyeBrowLeft"
    t.string "leftEyeBrowRight"
    t.string "leftEyeBrowUp"
    t.string "rightEyeBrowLeft"
    t.string "rightEyeBrowRight"
    t.string "rightEyeBrowUp"
    t.string "leftEyeLeft"
    t.string "leftEyeRight"
    t.string "leftEyeUp"
    t.string "leftEyeDown"
    t.string "rightEyeLeft"
    t.string "rightEyeRight"
    t.string "rightEyeUp"
    t.string "rightEyeDown"
    t.string "noseLeft"
    t.string "noseRight"
    t.string "mouthUp"
    t.string "mouthDown"
    t.string "leftPupil"
    t.string "rightPupil"
    t.string "upperJawlineLeft"
    t.string "midJawlineLeft"
    t.string "chinBottom"
    t.string "midJawlineRight"
    t.string "upperJawlineRight"
    t.string "brightness"
    t.string "sharpness"
    t.string "compare_result"
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id_id"], name: "index_images_on_user_id_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "report_id"
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.string "telephone_number"
    t.string "incident_date"
    t.text "summary"
    t.bigint "user_id_id"
    t.string "vehicle_urls"
    t.string "image_urls"
    t.text "data"
    t.index ["user_id_id"], name: "index_reports_on_user_id_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "vehicle_id"
    t.string "make"
    t.string "model"
    t.integer "year"
    t.string "plate"
    t.string "color"
    t.text "background"
    t.bigint "user_id_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.index ["user_id_id"], name: "index_vehicles_on_user_id_id"
  end

end
