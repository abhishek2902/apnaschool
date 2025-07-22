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

ActiveRecord::Schema[8.0].define(version: 2025_04_08_055019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "roll"
    t.integer "age"
    t.date "dateofbirth"
    t.string "sex"
    t.string "fathername"
    t.string "mothername"
    t.text "address"
    t.string "subject"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["mobile"], name: "index_admins_on_mobile", unique: true
    t.index ["roll"], name: "index_admins_on_roll", unique: true
  end

  create_table "attempts", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.bigint "user_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_attempts_on_test_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "doubts", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doubts_on_user_id"
  end

  create_table "grievances", force: :cascade do |t|
    t.string "name"
    t.text "text"
    t.boolean "flag"
    t.integer "likes", default: 0
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.integer "likes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.text "content"
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "option_d"
    t.string "correct_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "replies", force: :cascade do |t|
    t.string "name"
    t.text "text"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "grievance_id", null: false
    t.index ["grievance_id"], name: "index_replies_on_grievance_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "attempt_id", null: false
    t.bigint "question_id", null: false
    t.string "selected_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_responses_on_attempt_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "classname"
    t.integer "roll"
    t.integer "age"
    t.date "dateofbirth"
    t.string "sex"
    t.string "fathername"
    t.string "mothername"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["roll"], name: "index_students_on_roll", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "roll"
    t.integer "age"
    t.date "dateofbirth"
    t.string "sex"
    t.string "fathername"
    t.string "mothername"
    t.text "address"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["mobile"], name: "index_teachers_on_mobile", unique: true
    t.index ["roll"], name: "index_teachers_on_roll", unique: true
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "tests"
  add_foreign_key "attempts", "users"
  add_foreign_key "doubts", "users"
  add_foreign_key "questions", "tests"
  add_foreign_key "replies", "grievances"
  add_foreign_key "responses", "attempts"
  add_foreign_key "responses", "questions"
  add_foreign_key "tests", "users"
end
