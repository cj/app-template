# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 2021_01_02_233821) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("name")
    t.string("resource_type")
    t.bigint("resource_id")
    t.datetime("created_at", precision: 6, null: false)
    t.datetime("updated_at", precision: 6, null: false)
    t.index(["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id")
    t.index(["resource_type", "resource_id"], name: "index_roles_on_resource")
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("first_name", null: false)
    t.string("last_name", null: false)
    t.string("email", default: "", null: false)
    t.string("encrypted_password", default: "", null: false)
    t.string("reset_password_token")
    t.datetime("reset_password_sent_at")
    t.datetime("remember_created_at")
    t.integer("sign_in_count", default: 0, null: false)
    t.datetime("current_sign_in_at")
    t.datetime("last_sign_in_at")
    t.string("current_sign_in_ip")
    t.string("last_sign_in_ip")
    t.string("confirmation_token")
    t.datetime("confirmed_at")
    t.datetime("confirmation_sent_at")
    t.string("unconfirmed_email")
    t.integer("failed_attempts", default: 0, null: false)
    t.string("unlock_token")
    t.datetime("locked_at")
    t.string("time_zone")
    t.datetime("created_at", precision: 6, null: false)
    t.datetime("updated_at", precision: 6, null: false)
    t.string("invitation_token_ciphertext")
    t.datetime("invitation_created_at")
    t.datetime("invitation_sent_at")
    t.datetime("invitation_accepted_at")
    t.integer("invitation_limit")
    t.string("invited_by_type")
    t.bigint("invited_by_id")
    t.integer("invitations_count", default: 0)
    t.index(["confirmation_token"], name: "index_users_on_confirmation_token", unique: true)
    t.index(["email"], name: "index_users_on_email", unique: true)
    t.index(["first_name", "last_name"], name: "index_users_on_first_name_and_last_name")
    t.index(["first_name"], name: "index_users_on_first_name")
    t.index(["invitation_token_ciphertext"], name: "index_users_on_invitation_token_ciphertext", unique: true)
    t.index(["invited_by_id"], name: "index_users_on_invited_by_id")
    t.index(["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by")
    t.index(["last_name"], name: "index_users_on_last_name")
    t.index(["reset_password_token"], name: "index_users_on_reset_password_token", unique: true)
    t.index(["time_zone"], name: "index_users_on_time_zone")
    t.index(["unlock_token"], name: "index_users_on_unlock_token", unique: true)
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid("user_id")
    t.uuid("role_id")
    t.index(["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id")
  end
end
