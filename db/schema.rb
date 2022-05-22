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

ActiveRecord::Schema.define(version: 2022_04_06_201827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapter_scrape_settings", force: :cascade do |t|
    t.bigint "manga_id"
    t.string "origin_url"
    t.string "image_list_css_string"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "download_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "manga_id"
    t.integer "number"
  end

  create_table "manga_scrape_settings", force: :cascade do |t|
    t.bigint "manga_id"
    t.string "origin_url"
    t.string "chapter_list_css_string"
  end

  create_table "mangas", force: :cascade do |t|
    t.text "name"
    t.integer "language", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_chapter_id"
    t.integer "process", default: 0
    t.index ["current_chapter_id"], name: "mangas_current_chapter_id_uindex", unique: true
  end

end
