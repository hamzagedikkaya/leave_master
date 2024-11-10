# frozen_string_literal: true

class DropTeamsTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :teams
  end

  def down
    create_table :teams do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
