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

ActiveRecord::Schema.define(version: 2019_11_07_190250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_clubs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_list_books", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "book_list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_book_list_books_on_book_id"
    t.index ["book_list_id"], name: "index_book_list_books_on_book_list_id"
  end

  create_table "book_lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_book_lists_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "publisher"
    t.string "published_date"
    t.float "average_rating"
    t.integer "page_count"
    t.string "image"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "author"
    t.string "subtitle"
    t.string "volume_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_club_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content"
    t.index ["book_club_id"], name: "index_messages_on_book_club_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "book_list_books", "book_lists"
  add_foreign_key "book_list_books", "books"
  add_foreign_key "book_lists", "users"
  add_foreign_key "messages", "book_clubs"
  add_foreign_key "messages", "users"
end
