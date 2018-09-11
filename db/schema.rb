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

ActiveRecord::Schema.define(version: 20180911221205) do

  create_table "customers", force: :cascade do |t|
    t.string "name"
  end

  create_table "food_trucks", force: :cascade do |t|
    t.string "name"
    t.string "food_type"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "food_truck_id"
    t.string  "menu_item"
    t.index ["food_truck_id"], name: "index_menus_on_food_truck_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "food_truck_id"
    t.integer "customer_id"
    t.string  "order_item"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["food_truck_id"], name: "index_orders_on_food_truck_id"
  end

end
