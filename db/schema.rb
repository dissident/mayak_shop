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

ActiveRecord::Schema.define(version: 20160404041855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "nav_items", force: :cascade do |t|
    t.string   "title",                       null: false
    t.integer  "url_type",    default: 0,     null: false
    t.integer  "url_page_id"
    t.string   "url_text"
    t.integer  "prior",       default: 9,     null: false
    t.boolean  "hided",       default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "nav_items", ["hided"], name: "index_nav_items_on_hided", using: :btree
  add_index "nav_items", ["prior"], name: "index_nav_items_on_prior", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title",                        null: false
    t.string   "slug",                         null: false
    t.datetime "published_at",                 null: false
    t.string   "preview"
    t.text     "intro"
    t.text     "body"
    t.text     "seodata"
    t.boolean  "hided",        default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "news", ["hided"], name: "index_news_on_hided", using: :btree
  add_index "news", ["published_at"], name: "index_news_on_published_at", using: :btree
  add_index "news", ["slug"], name: "index_news_on_slug", unique: true, using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "path",                       null: false
    t.boolean  "fixed"
    t.text     "body"
    t.text     "seodata"
    t.integer  "prior",      default: 9,     null: false
    t.boolean  "hided",      default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["hided"], name: "index_pages_on_hided", using: :btree
  add_index "pages", ["path"], name: "index_pages_on_path", using: :btree
  add_index "pages", ["prior"], name: "index_pages_on_prior", using: :btree

  create_table "product_properties", force: :cascade do |t|
    t.string   "name"
    t.string   "latin_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_properties_prototypes", id: false, force: :cascade do |t|
    t.integer "product_property_id"
    t.integer "prototype_id"
  end

  add_index "product_properties_prototypes", ["product_property_id"], name: "index_product_properties_prototypes_on_product_property_id", using: :btree
  add_index "product_properties_prototypes", ["prototype_id"], name: "index_product_properties_prototypes_on_prototype_id", using: :btree

  create_table "product_property_values", force: :cascade do |t|
    t.string   "value"
    t.integer  "product_property_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "product_property_values", ["product_property_id"], name: "index_product_property_values_on_product_property_id", using: :btree

  create_table "product_property_values_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "product_property_value_id"
  end

  add_index "product_property_values_products", ["product_id"], name: "index_product_property_values_products_on_product_id", using: :btree
  add_index "product_property_values_products", ["product_property_value_id"], name: "products_property_value_id_index", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "prototype_id"
  end

  add_index "products", ["prototype_id"], name: "index_products_on_prototype_id", using: :btree

  create_table "products_taxons", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "taxon_id"
  end

  add_index "products_taxons", ["product_id"], name: "index_products_taxons_on_product_id", using: :btree
  add_index "products_taxons", ["taxon_id"], name: "index_products_taxons_on_taxon_id", using: :btree

  create_table "prototypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prototypes_taxonomies", id: false, force: :cascade do |t|
    t.integer "prototype_id"
    t.integer "taxonomy_id"
  end

  add_index "prototypes_taxonomies", ["prototype_id"], name: "index_prototypes_taxonomies_on_prototype_id", using: :btree
  add_index "prototypes_taxonomies", ["taxonomy_id"], name: "index_prototypes_taxonomies_on_taxonomy_id", using: :btree

  create_table "prototypes_variant_options", id: false, force: :cascade do |t|
    t.integer "prototype_id"
    t.integer "variant_option_id"
  end

  add_index "prototypes_variant_options", ["prototype_id"], name: "index_prototypes_variant_options_on_prototype_id", using: :btree
  add_index "prototypes_variant_options", ["variant_option_id"], name: "index_prototypes_variant_options_on_variant_option_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "ident",                      null: false
    t.string   "name"
    t.text     "descr"
    t.integer  "vtype"
    t.text     "val"
    t.string   "group"
    t.boolean  "often"
    t.boolean  "hidden",     default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "settings", ["hidden"], name: "index_settings_on_hidden", using: :btree
  add_index "settings", ["ident"], name: "index_settings_on_ident", using: :btree
  add_index "settings", ["often"], name: "index_settings_on_often", using: :btree

  create_table "static_files", force: :cascade do |t|
    t.integer  "holder_id"
    t.string   "holder_type"
    t.string   "file",        null: false
    t.string   "filetype"
    t.string   "name"
    t.float    "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "static_files", ["holder_type", "holder_id"], name: "index_static_files_on_holder_type_and_holder_id", using: :btree

  create_table "taxonomies", force: :cascade do |t|
    t.string   "name"
    t.string   "latin_name"
    t.boolean  "multiple",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "taxons", force: :cascade do |t|
    t.string   "name"
    t.string   "latin_name"
    t.integer  "taxonomy_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id", using: :btree

  create_table "variant_option_values", force: :cascade do |t|
    t.string   "value"
    t.integer  "variant_option_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "variant_option_values", ["variant_option_id"], name: "index_variant_option_values_on_variant_option_id", using: :btree

  create_table "variant_option_values_variants", id: false, force: :cascade do |t|
    t.integer "variant_id"
    t.integer "variant_option_value_id"
  end

  add_index "variant_option_values_variants", ["variant_id"], name: "index_variant_option_values_variants_on_variant_id", using: :btree
  add_index "variant_option_values_variants", ["variant_option_value_id"], name: "index_variant_option_values_variants_on_variant_option_value_id", using: :btree

  create_table "variant_options", force: :cascade do |t|
    t.string   "name"
    t.string   "latin_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string   "sku"
    t.string   "width"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree

  add_foreign_key "nav_items", "pages", column: "url_page_id", on_delete: :cascade
  add_foreign_key "product_property_values", "product_properties"
  add_foreign_key "taxons", "taxonomies"
  add_foreign_key "variant_option_values", "variant_options"
end
