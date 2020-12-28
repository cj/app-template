# frozen_string_literal: true

class AddCiphertextToUsers < ActiveRecord::Migration[6.1]
  def change
    %i(
      email reset_password_token current_sign_in_ip last_sign_in_ip confirmation_token unconfirmed_email unlock_token
    ).each do |field|
      # encrypted data
      add_column(:users, :"#{field}_ciphertext", :text)

      # encrypted data
      add_column(:users, :"#{field}_bidx", :string)

      if %i(current_sign_in_ip last_sign_in_ip).include?(field)
        add_index(:users, :"#{field}_bidx")
      else
        add_index(:users, :"#{field}_bidx", unique: true)
      end

      # drop original here unless we have existing users
      remove_column(:users, field)
    end

    %i(first_name last_name).each do |field|
      add_column(:users, :"#{field}_bidx", :text)
      add_column(:users, :"#{field}_ciphertext", :text)
      add_index(:users, :"#{field}_bidx")
    end

    add_column(:users, :time_zone, :string, index: true)
  end
end
