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

ActiveRecord::Schema.define(version: 20170803013503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cores", force: :cascade do |t|
    t.string   "bds_status"
    t.string   "sfdc_id"
    t.string   "sfdc_tier"
    t.string   "sfdc_sales_person"
    t.string   "sfdc_type"
    t.string   "sfdc_ult_grp"
    t.string   "sfdc_group"
    t.string   "sfdc_acct"
    t.string   "sfdc_street"
    t.string   "sfdc_city"
    t.string   "sfdc_state"
    t.string   "sfdc_ph"
    t.string   "sfdc_url"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "indexer_date"
    t.datetime "staffer_date"
    t.string   "staff_pf_sts"
    t.string   "loc_pf_sts"
    t.string   "staff_link"
    t.string   "staff_text"
    t.string   "location_link"
    t.string   "location_text"
    t.string   "staffer_sts"
    t.string   "sfdc_franchise"
    t.string   "sfdc_franch_cat"
    t.string   "sfdc_franch_cons"
    t.string   "template"
    t.string   "full_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "geo_date"
    t.string   "coordinates"
    t.string   "geo_sts"
    t.string   "cop_franch"
    t.string   "conf_cat"
    t.string   "sfdc_acct_url"
    t.string   "sfdc_ult_grp_id"
    t.string   "sfdc_group_id"
    t.string   "img_url"
    t.string   "sfdc_ult_rt"
    t.string   "sfdc_grp_rt"
    t.string   "sfdc_zip"
    t.string   "sfdc_clean_url"
    t.string   "crm_acct_pin"
    t.string   "crm_phones",        default: [],              array: true
    t.string   "who_sts"
    t.string   "match_score"
    t.string   "acct_match_sts"
    t.string   "ph_match_sts"
    t.string   "pin_match_sts"
    t.string   "url_match_sts"
    t.string   "acct_merge_sts"
    t.string   "alt_acct_pin"
    t.string   "alt_acct"
    t.string   "alt_street"
    t.string   "alt_city"
    t.string   "alt_state"
    t.string   "alt_zip"
    t.string   "alt_ph"
    t.string   "alt_url"
    t.string   "alt_source"
    t.string   "alt_address"
    t.string   "alt_template"
    t.string   "redirect_sts"
    t.string   "flagged_note"
    t.string   "bug_note"
    t.integer  "crm_staff_count",   default: 0
    t.integer  "web_staff_count",   default: 0
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "db_name"
    t.string   "db_alias"
    t.string   "col_name"
    t.string   "col_alias"
    t.string   "item_list",       default: [],              array: true
    t.integer  "col_total",       default: 0
    t.integer  "item_list_total", default: 0
    t.json     "obj_list",        default: {}
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "in_host_pos", force: :cascade do |t|
    t.string   "term"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "consolidated_term"
    t.string   "category"
    t.integer  "brand_count",       default: 0
    t.integer  "cat_count",         default: 0
  end

  create_table "in_text_pos", force: :cascade do |t|
    t.string   "term"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "consolidated_term"
    t.string   "category"
  end

  create_table "indexer_terms", force: :cascade do |t|
    t.string   "category"
    t.string   "sub_category"
    t.string   "criteria_term"
    t.string   "response_term"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "mth_name"
    t.integer  "criteria_count", default: 0
    t.integer  "response_count", default: 0
  end

  create_table "indexers", force: :cascade do |t|
    t.string   "raw_url"
    t.string   "redirect_status"
    t.string   "clean_url"
    t.string   "indexer_status"
    t.string   "staff_url"
    t.string   "staff_text"
    t.string   "location_url"
    t.string   "location_text"
    t.string   "template"
    t.string   "crm_id_arr",        default: [],                 array: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "loc_status"
    t.string   "stf_status"
    t.string   "contact_status"
    t.string   "contacts_link"
    t.string   "acct_name"
    t.string   "rt_sts"
    t.string   "cont_sts"
    t.string   "full_addr"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "phones",            default: [],                 array: true
    t.string   "acct_pin"
    t.string   "raw_street"
    t.string   "who_status"
    t.string   "geo_status"
    t.integer  "contacts_count",    default: 0
    t.string   "clean_url_crm_ids", default: [],                 array: true
    t.string   "acct_pin_crm_ids",  default: [],                 array: true
    t.boolean  "archive",           default: false
    t.string   "crm_acct_ids",      default: [],                 array: true
    t.string   "crm_ph_ids",        default: [],                 array: true
    t.string   "score100",          default: [],                 array: true
    t.string   "score75",           default: [],                 array: true
    t.string   "score50",           default: [],                 array: true
    t.string   "score25",           default: [],                 array: true
    t.string   "flagged_ids",       default: [],                 array: true
    t.string   "dropped_ids",       default: [],                 array: true
    t.string   "bug"
    t.string   "bug_note"
    t.string   "cop_type"
    t.string   "cop_franchises",    default: [],                 array: true
    t.string   "flagged_note"
    t.integer  "web_staff_count",   default: 0
    t.string   "merged_ids",        default: [],                 array: true
    t.datetime "scrape_date"
  end

  create_table "locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "city"
    t.string   "state"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "coordinates"
    t.string   "acct_name"
    t.string   "group_name"
    t.string   "ult_group_name"
    t.string   "source"
    t.string   "sfdc_id"
    t.string   "tier"
    t.string   "sales_person"
    t.string   "acct_type"
    t.string   "location_status"
    t.string   "url"
    t.string   "street"
    t.string   "address"
    t.string   "temporary_id"
    t.string   "geo_acct_name"
    t.string   "geo_full_addr"
    t.string   "phone"
    t.string   "map_url"
    t.string   "img_url"
    t.string   "place_id"
    t.string   "crm_source"
    t.string   "geo_root"
    t.string   "crm_root"
    t.string   "crm_url"
    t.string   "geo_franch_term"
    t.string   "geo_franch_cons"
    t.string   "geo_franch_cat"
    t.string   "crm_franch_term"
    t.string   "crm_franch_cons"
    t.string   "crm_franch_cat"
    t.string   "crm_phone"
    t.string   "geo_type"
    t.string   "coord_id_arr",     default: [],              array: true
    t.string   "sfdc_acct_url"
    t.string   "street_num"
    t.string   "street_text"
    t.string   "crm_street"
    t.string   "crm_city"
    t.string   "crm_state"
    t.string   "crm_zip"
    t.string   "crm_url_redirect"
    t.string   "geo_url_redirect"
    t.string   "sts_geo_crm"
    t.string   "sts_url"
    t.string   "sts_root"
    t.string   "sts_acct"
    t.string   "sts_addr"
    t.string   "sts_ph"
    t.string   "sts_duplicate"
    t.string   "url_arr",          default: [],              array: true
    t.string   "duplicate_arr",    default: [],              array: true
    t.string   "cop_franch_arr",   default: [],              array: true
    t.string   "cop_franch"
    t.string   "url_sts"
    t.string   "acct_sts"
    t.string   "addr_sts"
    t.string   "ph_sts"
    t.string   "sfdc_acct_pin"
    t.string   "geo_acct_pin"
  end

  create_table "staffers", force: :cascade do |t|
    t.string   "staffer_status"
    t.string   "cont_status"
    t.string   "cont_source"
    t.string   "sfdc_id"
    t.string   "sfdc_sales_person"
    t.string   "sfdc_type"
    t.string   "sfdc_cont_id"
    t.datetime "staffer_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "sfdc_tier"
    t.string   "domain"
    t.string   "acct_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "fname"
    t.string   "lname"
    t.string   "fullname"
    t.string   "job"
    t.string   "job_raw"
    t.string   "phone"
    t.string   "email"
    t.string   "full_address"
    t.string   "acct_pin"
    t.string   "cont_pin"
    t.string   "template"
    t.datetime "scrape_date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.integer  "role"
    t.string   "department"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "whos", force: :cascade do |t|
    t.string   "domain"
    t.string   "domain_id"
    t.string   "ip"
    t.string   "server1"
    t.string   "server2"
    t.string   "registrar_url"
    t.string   "registrar_id"
    t.string   "registrant_name"
    t.string   "registrant_organization"
    t.string   "registrant_address"
    t.string   "registrant_city"
    t.string   "registrant_zip"
    t.string   "registrant_state"
    t.string   "registrant_phone"
    t.string   "registrant_fax"
    t.string   "registrant_email"
    t.string   "registrant_url"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "who_status"
    t.string   "url_status"
    t.string   "who_addr_pin"
  end

end
