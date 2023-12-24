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

ActiveRecord::Schema[7.0].define(version: 2023_12_24_160541) do
  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "Temp Courses", null: false
    t.string "description"
    t.boolean "active_status", default: false
    t.integer "course_type", default: 0
    t.string "slug", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_type"], name: "index_courses_on_course_type"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "paper_elements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "element_type"
    t.text "text"
    t.text "link"
    t.integer "marks"
    t.integer "negative_marks"
    t.string "meta_data"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paper_id"
    t.index ["parent_id"], name: "index_paper_elements_on_parent_id"
  end

  create_table "papers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "active_status", default: false
    t.string "resource_link"
    t.string "slug", null: false
    t.integer "paper_type"
    t.bigint "course_id", null: false
    t.bigint "user_id"
    t.bigint "paper_element_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_papers_on_course_id"
    t.index ["paper_element_id"], name: "index_papers_on_paper_element_id"
    t.index ["user_id"], name: "index_papers_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_type", default: 0, null: false
    t.string "name", default: "Temp User", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "users"
  add_foreign_key "paper_elements", "paper_elements", column: "parent_id", on_delete: :cascade
  add_foreign_key "papers", "courses"
  add_foreign_key "papers", "paper_elements"
  add_foreign_key "papers", "users"
end
