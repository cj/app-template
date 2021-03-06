# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                          :uuid             not null, primary key
#  confirmation_sent_at        :datetime
#  confirmation_token          :string
#  confirmed_at                :datetime
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  failed_attempts             :integer          default(0), not null
#  first_name                  :string           not null
#  invitation_accepted_at      :datetime
#  invitation_created_at       :datetime
#  invitation_limit            :integer
#  invitation_sent_at          :datetime
#  invitation_token_ciphertext :string
#  invitations_count           :integer          default(0)
#  invited_by_type             :string
#  last_name                   :string           not null
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  locked_at                   :datetime
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  sign_in_count               :integer          default(0), not null
#  time_zone                   :string
#  unconfirmed_email           :string
#  unlock_token                :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  invited_by_id               :bigint
#
# Indexes
#
#  index_users_on_confirmation_token           (confirmation_token) UNIQUE
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_first_name                   (first_name)
#  index_users_on_first_name_and_last_name     (first_name,last_name)
#  index_users_on_invitation_token_ciphertext  (invitation_token_ciphertext) UNIQUE
#  index_users_on_invited_by                   (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id                (invited_by_id)
#  index_users_on_last_name                    (last_name)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_time_zone                    (time_zone)
#  index_users_on_unlock_token                 (unlock_token) UNIQUE
#
class User < ApplicationRecord
  rolify
  has_person_name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
:masqueradable, :omniauthable, :lockable, :trackable, :timeoutable

  # Validations
  validates :name, presence: true
  validates :password_confirmation, presence: true, on: :create
end
