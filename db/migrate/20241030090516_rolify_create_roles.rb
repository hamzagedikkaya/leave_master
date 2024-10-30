# frozen_string_literal: true

class RolifyCreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.references :resource, polymorphic: true, index: true
      t.string :menu, array: true, default: []

      t.timestamps
    end

    add_index :roles, %i[name resource_type resource_id]
  end
end
