# frozen_string_literal: true

class DeviseInvitableAddToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table(:users) do |t|
      t.string(:invitation_token_ciphertext)
      t.datetime(:invitation_created_at)
      t.datetime(:invitation_sent_at)
      t.datetime(:invitation_accepted_at)
      t.integer(:invitation_limit)
      t.references(:invited_by, polymorphic: true)
      t.integer(:invitations_count, default: 0)

      t.index(:invitation_token_ciphertext, unique: true) # for invitable
      t.index(:invited_by_id)
    end
  end
end
