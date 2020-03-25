class CreateUsers < ActiveRecord::Migration[4.2]
  def up
    create_table :users
  end

  def self.down
    drop_table :users
  end
end
