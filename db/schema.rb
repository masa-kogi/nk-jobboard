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

ActiveRecord::Schema[7.0].define(version: 2023_08_04_124040) do
  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "application_status_maps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_application_id", null: false
    t.bigint "application_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_status_id"], name: "index_application_status_maps_on_application_status_id"
    t.index ["job_application_id"], name: "index_application_status_maps_on_job_application_id"
  end

  create_table "application_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "department_id", null: false
    t.bigint "position_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "qualifications", null: false
    t.text "skills", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employee_profiles_on_department_id"
    t.index ["employee_id"], name: "index_employee_profiles_on_employee_id"
    t.index ["position_id"], name: "index_employee_profiles_on_position_id"
  end

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["username"], name: "index_employees_on_username", unique: true
  end

  create_table "job_applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "applicant_id", null: false
    t.text "reason_for_application", null: false
    t.text "self_promotion", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_job_applications_on_applicant_id"
    t.index ["job_id"], name: "index_job_applications_on_job_id"
  end

  create_table "job_contact_person_maps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "contact_person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_person_id"], name: "index_job_contact_person_maps_on_contact_person_id"
    t.index ["job_id", "contact_person_id"], name: "index_job_contact_person_maps_on_job_id_and_contact_person_id", unique: true
    t.index ["job_id"], name: "index_job_contact_person_maps_on_job_id"
  end

  create_table "job_status_maps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "job_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_status_maps_on_job_id"
    t.index ["job_status_id"], name: "index_job_status_maps_on_job_status_id"
  end

  create_table "job_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "category_id", null: false
    t.bigint "department_id", null: false
    t.bigint "work_location_id", null: false
    t.text "job_description", null: false
    t.text "application_requirement", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["department_id"], name: "index_jobs_on_department_id"
    t.index ["work_location_id"], name: "index_jobs_on_work_location_id"
  end

  create_table "positions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruiter_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "recruiter_id", null: false
    t.bigint "department_id", null: false
    t.bigint "position_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_recruiter_profiles_on_department_id"
    t.index ["position_id"], name: "index_recruiter_profiles_on_position_id"
    t.index ["recruiter_id"], name: "index_recruiter_profiles_on_recruiter_id"
  end

  create_table "recruiters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_recruiters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true
    t.index ["username"], name: "index_recruiters_on_username", unique: true
  end

  create_table "work_locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "application_status_maps", "application_statuses"
  add_foreign_key "application_status_maps", "job_applications"
  add_foreign_key "employee_profiles", "departments"
  add_foreign_key "employee_profiles", "employees"
  add_foreign_key "employee_profiles", "positions"
  add_foreign_key "job_applications", "employee_profiles", column: "applicant_id"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_contact_person_maps", "jobs"
  add_foreign_key "job_contact_person_maps", "recruiter_profiles", column: "contact_person_id"
  add_foreign_key "job_status_maps", "job_statuses"
  add_foreign_key "job_status_maps", "jobs"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "departments"
  add_foreign_key "jobs", "work_locations"
  add_foreign_key "recruiter_profiles", "departments"
  add_foreign_key "recruiter_profiles", "positions"
  add_foreign_key "recruiter_profiles", "recruiters"
end
