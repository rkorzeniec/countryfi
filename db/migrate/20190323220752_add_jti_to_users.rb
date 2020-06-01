# frozen_string_literal: true

class AddJtiToUsers < ActiveRecord::Migration[5.2]
  class User < ApplicationRecord; end

  def up
    # rubocop:disable Rails/NotNullColumn
    add_column :users, :jti_token, :string, null: false, after: :email
    # rubocop:enable Rails/NotNullColumn

    User.find_each do |user|
      execute(%(
        UPDATE users
        SET users.jti_token = "#{SecureRandom.base58(24)}"
        WHERE users.id = #{user.id}
      ))
    end

    add_index :users, :jti_token, unique: true
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :jti_token
      t.remove_index :jti_token
    end
  end
end
