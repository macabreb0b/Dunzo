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

ActiveRecord::Schema.define(version: 20140302201646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.string   "email"
    t.string   "phone"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "deliverables", force: true do |t|
    t.integer  "project_id"
    t.string   "name",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_deliverable_id"
    t.boolean  "completed"
    t.integer  "hourly"
  end

  add_index "deliverables", ["project_id"], name: "index_deliverables_on_project_id", using: :btree

  create_table "hours", force: true do |t|
    t.integer  "deliverable_id"
    t.boolean  "invoiced"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hours", ["deliverable_id"], name: "index_hours_on_deliverable_id", using: :btree

  create_table "notes", force: true do |t|
    t.text     "body"
    t.integer  "notable_id",   null: false
    t.string   "notable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["notable_id", "notable_type"], name: "index_notes_on_notable_id_and_notable_type", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "client_id",   null: false
    t.integer  "user_id",     null: false
    t.string   "name",        null: false
    t.boolean  "open",        null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "requirements", force: true do |t|
    t.string   "body",             null: false
    t.integer  "requireable_id",   null: false
    t.string   "requireable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requirements", ["requireable_id", "requireable_type"], name: "index_requirements_on_requireable_id_and_requireable_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "token",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
