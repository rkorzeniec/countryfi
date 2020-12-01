# frozen_string_literal: true

class AddProfileFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :public_profile, after: :admin, default: false
      t.index %i[public_profile profile]
    end
  end
end
