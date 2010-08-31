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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100710035523) do

  create_table "client_stores", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "client_store_type"
    t.string   "name"
    t.datetime "deleted_at"
    t.text     "data",              :limit => 2147483647
  end

  add_index "client_stores", ["user_id", "client_store_type"], :name => "index_client_stores_on_user_id_and_client_store_type"
  add_index "client_stores", ["user_id"], :name => "index_client_stores_on_user_id"

  create_table "grape_varieties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "wine_type"
  end

  create_table "multi_element_choices", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id",              :null => false
    t.integer  "multi_element_value_id", :null => false
  end

  add_index "multi_element_choices", ["multi_element_value_id"], :name => "multi_element_choice_value_id"
  add_index "multi_element_choices", ["target_id", "multi_element_value_id"], :name => "multi_element_choices_index_cl_attr_val", :unique => true

  create_table "multi_element_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "target_class_name", :null => false
    t.string   "name"
    t.string   "description"
  end

  create_table "multi_element_values", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "value"
    t.integer  "multi_element_group_id"
  end

  add_index "multi_element_values", ["multi_element_group_id"], :name => "index_multi_element_values_on_multi_element_group_id"

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
