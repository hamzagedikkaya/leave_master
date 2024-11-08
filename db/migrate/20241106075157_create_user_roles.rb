# frozen_string_literal: true

class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :role, null: false, foreign_key: true, index: true

      t.timestamps
    end
    add_index :user_roles, %i[user_id role_id], unique: true
  end
end
