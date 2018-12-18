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

ActiveRecord::Schema.define(version: 2018_12_11_041419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.integer "study_space_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_note_histories", force: :cascade do |t|
    t.integer "chapter_note_id"
    t.integer "user_id"
    t.integer "revision_number"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_notes", force: :cascade do |t|
    t.integer "study_space_id"
    t.integer "chapter_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.boolean "requires_addition_of_bismillah"
  end

  create_table "study_spaces", force: :cascade do |t|
    t.integer "user_id"
    t.integer "study_space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.integer "verse_id"
    t.string "author"
    t.text "language"
    t.text "content"
  end

  create_table "user_study_spaces", force: :cascade do |t|
    t.string "space_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verse_note_histories", force: :cascade do |t|
    t.integer "verse_note_id"
    t.integer "user_id"
    t.integer "revision_number"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verse_notes", force: :cascade do |t|
    t.integer "study_space_id"
    t.integer "verse_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verses", force: :cascade do |t|
    t.integer "chapter_id"
    t.integer "number_in_chapter"
    t.text "content"
  end

end
