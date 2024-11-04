# frozen_string_literal: true

class AddTwoFactorFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :users, bulk: true do |t|
      t.string  :otp_secret
      t.boolean :otp_required_for_login, default: false, null: false
    end
  end
end
