# frozen_string_literal: true

class CreateLeaveTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
