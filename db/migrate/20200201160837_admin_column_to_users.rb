# frozen_string_literal: true
class AdminColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, after: :preferences, default: false
  end
end
