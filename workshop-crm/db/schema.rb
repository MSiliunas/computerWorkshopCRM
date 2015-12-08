# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151207232658) do

  create_table "clients", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "computers", force: :cascade do |t|
    t.text     "specs"
    t.string   "serial"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "computers", ["client_id"], name: "index_computers_on_client_id"

  create_table "discounts", force: :cascade do |t|
    t.integer  "value"
    t.string   "discount_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "discounts_to_order_details", force: :cascade do |t|
    t.integer  "order_detail_id"
    t.integer  "discount_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "discounts_to_order_details", ["discount_id"], name: "index_discounts_to_order_details_on_discount_id"
  add_index "discounts_to_order_details", ["order_detail_id"], name: "index_discounts_to_order_details_on_order_detail_id"

  create_table "employees", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "status"
    t.integer  "order_id"
    t.integer  "discount_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "order_details", ["discount_id"], name: "index_order_details_on_discount_id"
  add_index "order_details", ["employee_id"], name: "index_order_details_on_employee_id"
  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id"

  create_table "order_details_to_tasks", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_details_to_tasks", ["order_id"], name: "index_order_details_to_tasks_on_order_id"
  add_index "order_details_to_tasks", ["task_id"], name: "index_order_details_to_tasks_on_task_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "order_detail_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "orders", ["client_id"], name: "index_orders_on_client_id"
  add_index "orders", ["order_detail_id"], name: "index_orders_on_order_detail_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
