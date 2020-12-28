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

ActiveRecord::Schema.define(version: 2020_12_18_220420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("encrypted_password", default: "", null: false)
    t.datetime("reset_password_sent_at")
    t.datetime("remember_created_at")
    t.integer("sign_in_count", default: 0, null: false)
    t.datetime("current_sign_in_at")
    t.datetime("last_sign_in_at")
    t.datetime("confirmed_at")
    t.datetime("confirmation_sent_at")
    t.integer("failed_attempts", default: 0, null: false)
    t.datetime("locked_at")
    t.datetime("created_at", precision: 6, null: false)
    t.datetime("updated_at", precision: 6, null: false)
    t.text("email_ciphertext")
    t.string("email_bidx")
    t.text("reset_password_token_ciphertext")
    t.string("reset_password_token_bidx")
    t.text("current_sign_in_ip_ciphertext")
    t.string("current_sign_in_ip_bidx")
    t.text("last_sign_in_ip_ciphertext")
    t.string("last_sign_in_ip_bidx")
    t.text("confirmation_token_ciphertext")
    t.string("confirmation_token_bidx")
    t.text("unconfirmed_email_ciphertext")
    t.string("unconfirmed_email_bidx")
    t.text("unlock_token_ciphertext")
    t.string("unlock_token_bidx")
    t.text("first_name_bidx")
    t.text("first_name_ciphertext")
    t.text("last_name_bidx")
    t.text("last_name_ciphertext")
    t.string("time_zone")
    t.string("invitation_token_ciphertext")
    t.datetime("invitation_created_at")
    t.datetime("invitation_sent_at")
    t.datetime("invitation_accepted_at")
    t.integer("invitation_limit")
    t.string("invited_by_type")
    t.bigint("invited_by_id")
    t.integer("invitations_count", default: 0)
    t.index(["confirmation_token_bidx"], name: "index_users_on_confirmation_token_bidx", unique: true)
    t.index(["current_sign_in_ip_bidx"], name: "index_users_on_current_sign_in_ip_bidx")
    t.index(["email_bidx"], name: "index_users_on_email_bidx", unique: true)
    t.index(["first_name_bidx"], name: "index_users_on_first_name_bidx")
    t.index(["invitation_token_ciphertext"], name: "index_users_on_invitation_token_ciphertext", unique: true)
    t.index(["invited_by_id"], name: "index_users_on_invited_by_id")
    t.index(["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by")
    t.index(["last_name_bidx"], name: "index_users_on_last_name_bidx")
    t.index(["last_sign_in_ip_bidx"], name: "index_users_on_last_sign_in_ip_bidx")
    t.index(["reset_password_token_bidx"], name: "index_users_on_reset_password_token_bidx", unique: true)
    t.index(["unconfirmed_email_bidx"], name: "index_users_on_unconfirmed_email_bidx", unique: true)
    t.index(["unlock_token_bidx"], name: "index_users_on_unlock_token_bidx", unique: true)
  end
end
