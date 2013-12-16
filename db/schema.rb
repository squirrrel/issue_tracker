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

ActiveRecord::Schema.define(version: 20131216133946) do

  create_table "comments", force: true do |t|
    t.string   "current_user_or_customer_name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
  end

  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id"

  create_table "engineers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "engineers", ["email"], name: "index_engineers_on_email", unique: true
  add_index "engineers", ["reset_password_token"], name: "index_engineers_on_reset_password_token", unique: true

  create_table "tickets", force: true do |t|
    t.string   "ref_number"
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "department"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "engineer_id"
    t.string   "status"
  end

  add_index "tickets", ["engineer_id"], name: "index_tickets_on_engineer_id"

end
