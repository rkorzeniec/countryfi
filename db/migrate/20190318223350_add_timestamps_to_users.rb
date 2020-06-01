# frozen_string_literal: true

class AddTimestampsToUsers < ActiveRecord::Migration[5.2]
  def change
    # rubocop:disable Rails/ReversibleMigration
    add_timestamps :users, default: Time.zone.now
    change_column_default :users, :created_at, nil
    change_column_default :users, :updated_at, nil
    # rubocop:enable Rails/ReversibleMigration
  end
end
