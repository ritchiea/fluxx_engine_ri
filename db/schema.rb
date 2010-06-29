# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100629142857) do

  create_table "grape_varieties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "wine_type"
  end

  create_table "realtime_updates", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action",           :null => false
    t.integer  "user_id"
    t.integer  "model_id",         :null => false
    t.string   "type_name",        :null => false
    t.string   "model_class",      :null => false
    t.text     "delta_attributes", :null => false
  end

  create_table "wines", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",             :null => false
    t.integer  "grape_variety_id"
    t.datetime "locked_until"
    t.integer  "locked_by_id"
  end

end
