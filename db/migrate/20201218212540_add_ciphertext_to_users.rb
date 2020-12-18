# frozen_string_literal: true

class AddCiphertextToUsers < ActiveRecord::Migration[6.1]
  def change
    %i(
      email reset_password_token current_sign_in_ip last_sign_in_ip confirmation_token unconfirmed_email unlock_token
    ).each do |field|
      # encrypted data
      add_column(:users, :"#{field}_ciphertext", :text)

      # drop original here unless we have existing users
      remove_column(:users, field)
    end

    add_column(:users, :name_ciphertext, :text)

    %i(email unconfirmed_email name).each do |field|
      # encrypted data
      add_column(:users, :"#{field}_bidx", :string)
    end
  end
end
