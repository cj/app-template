# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  confirmation_sent_at            :datetime
#  confirmation_token_bidx         :string
#  confirmation_token_ciphertext   :text
#  confirmed_at                    :datetime
#  current_sign_in_at              :datetime
#  current_sign_in_ip_bidx         :string
#  current_sign_in_ip_ciphertext   :text
#  email_bidx                      :string
#  email_ciphertext                :text
#  encrypted_password              :string           default(""), not null
#  failed_attempts                 :integer          default(0), not null
#  invitation_accepted_at          :datetime
#  invitation_created_at           :datetime
#  invitation_limit                :integer
#  invitation_sent_at              :datetime
#  invitation_token_ciphertext     :string
#  invitations_count               :integer          default(0)
#  invited_by_type                 :string
#  last_sign_in_at                 :datetime
#  last_sign_in_ip_bidx            :string
#  last_sign_in_ip_ciphertext      :text
#  locked_at                       :datetime
#  name_bidx                       :text
#  name_ciphertext                 :text
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token_bidx       :string
#  reset_password_token_ciphertext :text
#  sign_in_count                   :integer          default(0), not null
#  unconfirmed_email_bidx          :string
#  unconfirmed_email_ciphertext    :text
#  unlock_token_bidx               :string
#  unlock_token_ciphertext         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  invited_by_id                   :bigint
#
# Indexes
#
#  index_users_on_confirmation_token_bidx      (confirmation_token_bidx) UNIQUE
#  index_users_on_current_sign_in_ip_bidx      (current_sign_in_ip_bidx)
#  index_users_on_email_bidx                   (email_bidx) UNIQUE
#  index_users_on_invitation_token_ciphertext  (invitation_token_ciphertext) UNIQUE
#  index_users_on_invited_by                   (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id                (invited_by_id)
#  index_users_on_last_sign_in_ip_bidx         (last_sign_in_ip_bidx)
#  index_users_on_name_bidx                    (name_bidx)
#  index_users_on_reset_password_token_bidx    (reset_password_token_bidx) UNIQUE
#  index_users_on_unconfirmed_email_bidx       (unconfirmed_email_bidx) UNIQUE
#  index_users_on_unlock_token_bidx            (unlock_token_bidx) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
:masqueradable, :omniauthable, :lockable, :trackable, :timeoutable

  encrypts :email, :reset_password_token, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token,
:unconfirmed_email, :unlock_token, :name, :invitation_token

  blind_index :email, :unconfirmed_email, :name, :reset_password_token, :confirmation_token, :unlock_token,
:invitation_token
end
