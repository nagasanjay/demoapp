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

ActiveRecord::Schema.define(version: 2021_06_08_044113) do

  create_table "food_services", charset: "latin1", force: :cascade do |t|
    t.string "contact_number"
    t.string "status"
    t.json "time_interval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.decimal "cost", precision: 10
    t.integer "units"
    t.json "includes"
    t.integer "available_count"
    t.bigint "food_service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_service_id"], name: "index_foods_on_food_service_id"
  end

  create_table "orders", charset: "latin1", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "cost", precision: 10
    t.boolean "delivered"
    t.bigint "user_id", null: false
    t.bigint "food_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_orders_on_food_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "services", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.string "servicable_type", null: false
    t.bigint "servicable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["servicable_type", "servicable_id"], name: "index_services_on_servicable"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "users", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.string "userType"
    t.string "locality"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "foods", "food_services"
  add_foreign_key "orders", "foods"
  add_foreign_key "orders", "users"
  add_foreign_key "services", "users"
end
