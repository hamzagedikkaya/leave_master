# frozen_string_literal: true

class AddLocaleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :locale, :string, default: "en"
  end
end
