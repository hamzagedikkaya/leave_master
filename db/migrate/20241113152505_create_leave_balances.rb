# frozen_string_literal: true

class CreateLeaveBalances < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_balances do |t|
      t.references :user, null: false, foreign_key: true
      t.date       :start_date
      t.integer    :total_leave_days
      t.integer    :used_leave_days

      t.timestamps
    end
  end
end
