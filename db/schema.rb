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

ActiveRecord::Schema.define(version: 20131203185451) do

  create_table "coupons", force: true do |t|
    t.string   "serial"
    t.datetime "sent"
    t.datetime "delivered"
    t.string   "recipient"
    t.integer  "serie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "ip"
    t.string   "ip2"
    t.string   "full_name"
  end

  add_index "coupons", ["serie_id"], name: "index_coupons_on_serie_id"

  create_table "series", force: true do |t|
    t.string   "name"
    t.float    "value"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.string   "token"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
