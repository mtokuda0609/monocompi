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

ActiveRecord::Schema.define(version: 20170629012620) do

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "user_id"
    t.integer "benefit"
    t.integer "stock"
    t.string "rk_code"
    t.string "rk_name"
    t.integer "rk_price"
    t.string "rk_url"
    t.string "rk_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ys_code"
    t.string "ys_name"
    t.integer "ys_price"
    t.string "ys_url"
    t.string "ys_image_url"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "user_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_user_items_on_item_id"
    t.index ["user_id", "item_id"], name: "index_user_items_on_user_id_and_item_id", unique: true
    t.index ["user_id"], name: "index_user_items_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fam_name"
    t.string "giv_name"
    t.string "fam_name_kana"
    t.string "giv_name_kana"
  end

  add_foreign_key "items", "users"
  add_foreign_key "user_items", "items"
  add_foreign_key "user_items", "users"
end
