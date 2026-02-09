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

ActiveRecord::Schema[8.1].define(version: 2026_02_09_104101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "created_at", null: false
    t.bigint "dish_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["dish_id"], name: "index_cart_items_on_dish_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.decimal "price"
    t.bigint "restaurant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "dish_id", null: false
    t.bigint "order_id", null: false
    t.integer "price"
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_order_items_on_dish_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.bigint "restaurant_id", null: false
    t.integer "status"
    t.integer "total_amount"
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.decimal "rating"
    t.bigint "restaurant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_ratings_on_customer_id"
    t.index ["restaurant_id"], name: "index_ratings_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.bigint "owner_id", null: false
    t.decimal "rating", precision: 3, scale: 2, default: "3.0"
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_restaurants_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "type"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "dishes"
  add_foreign_key "carts", "users", column: "customer_id"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "order_items", "dishes"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "orders", "users", column: "customer_id"
  add_foreign_key "ratings", "restaurants"
  add_foreign_key "ratings", "users", column: "customer_id"
  add_foreign_key "restaurants", "users", column: "owner_id"
end
