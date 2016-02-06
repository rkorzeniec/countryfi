class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users
  end

  def self.down
    drop_table :users
  end
end
