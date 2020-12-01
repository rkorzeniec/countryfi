# frozen_string_literal: true

class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :profile, after: :admin
      t.index :profile, unique: true
    end
  end
end
