# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[4.2]
  def up
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :users
    # rubocop:enable Rails/CreateTableWithTimestamps
  end

  def self.down
    drop_table :users
  end
end
