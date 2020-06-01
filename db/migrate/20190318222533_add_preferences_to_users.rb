# frozen_string_literal: true
class AddPreferencesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :preferences, :json, after: :last_sign_in_ip
  end
end
