# frozen_string_literal: true

class CreateLeaveRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :leave_type, null: false, foreign_key: true
      t.date       :start_date
      t.date       :end_date
      t.integer    :status
      t.string     :location
      t.text       :description

      t.timestamps
    end
  end
end
