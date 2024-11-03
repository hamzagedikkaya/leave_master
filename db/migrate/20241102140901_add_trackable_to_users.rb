# frozen_string_literal: true

class AddTrackableToUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :users, bulk: true do |t|
      t.integer  :sign_in_count
      t.datetime :last_sign_in_at
      t.string   :last_sign_in_ip
      t.datetime :current_sign_in_at
      t.string   :current_sign_in_ip
    end
  end
end
