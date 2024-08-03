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

ActiveRecord::Schema[7.0].define(version: 2024_08_03_164147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "otp"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assigned_center_modules", force: :cascade do |t|
    t.bigint "center_id", null: false
    t.bigint "software_module_id", null: false
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id", "software_module_id"], name: "assigned_center_modules_index", unique: true
    t.index ["center_id"], name: "index_assigned_center_modules_on_center_id"
    t.index ["software_module_id"], name: "index_assigned_center_modules_on_software_module_id"
  end

  create_table "attention_distractors", force: :cascade do |t|
    t.string "name"
    t.float "time_following_it_seconds"
    t.bigint "attention_performance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attention_performance_id"], name: "index_attention_distractors_on_attention_performance_id"
  end

  create_table "attention_interruptions", force: :cascade do |t|
    t.float "duration_seconds"
    t.bigint "attention_performance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attention_performance_id"], name: "index_attention_interruptions_on_attention_performance_id"
  end

  create_table "attention_performances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attention_targets", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "hit_time"
    t.bigint "attention_performance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attention_performance_id"], name: "index_attention_targets_on_attention_performance_id"
  end

  create_table "center_social_links", force: :cascade do |t|
    t.bigint "center_id", null: false
    t.string "link"
    t.integer "link_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id"], name: "index_center_social_links_on_center_id"
    t.index ["link"], name: "index_center_social_links_on_link", unique: true
  end

  create_table "center_specialties", force: :cascade do |t|
    t.bigint "center_id", null: false
    t.bigint "specialty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id", "specialty_id"], name: "index_center_specialties_on_center_id_and_specialty_id", unique: true
    t.index ["center_id"], name: "index_center_specialties_on_center_id"
    t.index ["specialty_id"], name: "index_center_specialties_on_specialty_id"
  end

  create_table "centers", force: :cascade do |t|
    t.string "name"
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "latitude", precision: 10, scale: 6
    t.string "website"
    t.string "logo"
    t.string "certificate"
    t.string "registration_number"
    t.string "tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone_number"
    t.index ["email"], name: "index_centers_on_email", unique: true
    t.index ["latitude", "longitude"], name: "index_centers_on_latitude_and_longitude", unique: true
    t.index ["phone_number"], name: "index_centers_on_phone_number", unique: true
    t.index ["registration_number"], name: "index_centers_on_registration_number", unique: true
    t.index ["tax_id"], name: "index_centers_on_tax_id", unique: true
    t.index ["website"], name: "index_centers_on_website", unique: true
  end

  create_table "child_centers", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "center_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id"], name: "index_child_centers_on_center_id"
    t.index ["child_id", "center_id"], name: "index_child_centers_on_child_id_and_center_id", unique: true
    t.index ["child_id"], name: "index_child_centers_on_child_id"
  end

  create_table "child_diagnoses", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "diagnosis_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id", "diagnosis_id"], name: "index_child_diagnoses_on_child_id_and_diagnosis_id", unique: true
    t.index ["child_id"], name: "index_child_diagnoses_on_child_id"
    t.index ["diagnosis_id"], name: "index_child_diagnoses_on_diagnosis_id"
  end

  create_table "child_doctors", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "child_id", null: false
    t.bigint "center_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id"], name: "index_child_doctors_on_center_id"
    t.index ["child_id", "doctor_id", "center_id"], name: "index_child_doctors_on_child_id_and_doctor_id_and_center_id", unique: true
    t.index ["child_id"], name: "index_child_doctors_on_child_id"
    t.index ["doctor_id"], name: "index_child_doctors_on_doctor_id"
  end

  create_table "child_software_modules", force: :cascade do |t|
    t.bigint "software_module_id", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "center_id", null: false
    t.index ["center_id"], name: "index_child_software_modules_on_center_id"
    t.index ["child_id", "software_module_id", "center_id"], name: "child_modules_index", unique: true
    t.index ["child_id"], name: "index_child_software_modules_on_child_id"
    t.index ["software_module_id"], name: "index_child_software_modules_on_software_module_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["email"], name: "index_children_on_email", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
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

  create_table "diagnoses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_diagnoses_on_name", unique: true
  end

  create_table "doctor_centers", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "center_id", null: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["center_id"], name: "index_doctor_centers_on_center_id"
    t.index ["doctor_id", "center_id"], name: "index_doctor_centers_on_doctor_id_and_center_id", unique: true
    t.index ["doctor_id"], name: "index_doctor_centers_on_doctor_id"
  end

  create_table "doctor_specialties", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "specialty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_specialties_on_doctor_id"
    t.index ["specialty_id"], name: "index_doctor_specialties_on_specialty_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "degree"
    t.string "university"
    t.boolean "is_email_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo", null: false
    t.string "certificate", null: false
    t.index ["email"], name: "index_doctors_on_email", unique: true
  end

  create_table "headsets", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "model"
    t.string "version"
    t.string "key"
    t.bigint "center_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["center_id"], name: "index_headsets_on_center_id"
    t.index ["discarded_at"], name: "index_headsets_on_discarded_at"
    t.index ["key"], name: "index_headsets_on_key", unique: true
    t.index ["name", "center_id"], name: "index_headsets_on_name_and_center_id", unique: true
  end

  create_table "otps", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.string "code"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code_type", default: 0
    t.index ["doctor_id", "code_type"], name: "index_otps_on_doctor_id_and_code_type", unique: true
    t.index ["doctor_id"], name: "index_otps_on_doctor_id"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "session_module_id", null: false
    t.integer "level"
    t.string "performanceable_type", null: false
    t.bigint "performanceable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["performanceable_type", "performanceable_id"], name: "index_performances_on_performanceable"
    t.index ["session_module_id"], name: "index_performances_on_session_module_id"
  end

  create_table "session_comments", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id", "name"], name: "index_session_comments_on_session_id_and_name", unique: true
    t.index ["session_id"], name: "index_session_comments_on_session_id"
  end

  create_table "session_doctors", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "session_id"], name: "index_session_doctors_on_doctor_id_and_session_id", unique: true
    t.index ["doctor_id"], name: "index_session_doctors_on_doctor_id"
    t.index ["session_id"], name: "index_session_doctors_on_session_id"
  end

  create_table "session_modules", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "software_module_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id", "software_module_id"], name: "index_session_modules_on_session_id_and_software_module_id", unique: true
    t.index ["session_id"], name: "index_session_modules_on_session_id"
    t.index ["software_module_id"], name: "index_session_modules_on_software_module_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "center_id", null: false
    t.bigint "headset_id", null: false
    t.bigint "child_id", null: false
    t.integer "evaluation"
    t.float "duration"
    t.boolean "is_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "ended_at"
    t.float "vr_duration"
    t.string "session_id"
    t.text "note"
    t.string "evaluation_file"
    t.index ["center_id"], name: "index_sessions_on_center_id"
    t.index ["child_id"], name: "index_sessions_on_child_id"
    t.index ["headset_id"], name: "index_sessions_on_headset_id"
  end

  create_table "software_module_skills", force: :cascade do |t|
    t.bigint "software_module_id", null: false
    t.bigint "targeted_skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["software_module_id", "targeted_skill_id"], name: "software_module_skills_index", unique: true
    t.index ["software_module_id"], name: "index_software_module_skills_on_software_module_id"
    t.index ["targeted_skill_id"], name: "index_software_module_skills_on_targeted_skill_id"
  end

  create_table "software_modules", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.integer "technology"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_age"
    t.integer "max_age"
    t.string "image"
    t.string "package_name"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "targeted_skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_targeted_skills_on_name", unique: true
  end

  add_foreign_key "assigned_center_modules", "centers"
  add_foreign_key "assigned_center_modules", "software_modules"
  add_foreign_key "attention_distractors", "attention_performances"
  add_foreign_key "attention_interruptions", "attention_performances"
  add_foreign_key "attention_targets", "attention_performances"
  add_foreign_key "center_social_links", "centers"
  add_foreign_key "center_specialties", "centers"
  add_foreign_key "center_specialties", "specialties"
  add_foreign_key "child_centers", "centers"
  add_foreign_key "child_centers", "children"
  add_foreign_key "child_diagnoses", "children"
  add_foreign_key "child_diagnoses", "diagnoses"
  add_foreign_key "child_doctors", "centers"
  add_foreign_key "child_doctors", "children"
  add_foreign_key "child_doctors", "doctors"
  add_foreign_key "child_software_modules", "centers"
  add_foreign_key "child_software_modules", "children"
  add_foreign_key "child_software_modules", "software_modules"
  add_foreign_key "doctor_centers", "centers"
  add_foreign_key "doctor_centers", "doctors"
  add_foreign_key "doctor_specialties", "doctors"
  add_foreign_key "doctor_specialties", "specialties"
  add_foreign_key "headsets", "centers"
  add_foreign_key "otps", "doctors"
  add_foreign_key "performances", "session_modules"
  add_foreign_key "session_comments", "sessions"
  add_foreign_key "session_doctors", "doctors"
  add_foreign_key "session_doctors", "sessions"
  add_foreign_key "session_modules", "sessions"
  add_foreign_key "session_modules", "software_modules"
  add_foreign_key "sessions", "centers"
  add_foreign_key "sessions", "children"
  add_foreign_key "sessions", "headsets"
  add_foreign_key "software_module_skills", "software_modules"
  add_foreign_key "software_module_skills", "targeted_skills"
end
