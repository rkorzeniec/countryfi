class AddJtiToUsers < ActiveRecord::Migration[5.2]
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :jti_token, :string, null: false, after: :email
    add_index :users, :jti_token, unique: true

    User.find_each do |user|
      execute(%(
        UPDATE users
        SET users.jti_token = "#{SecureRandom.base58(24)}"
        WHERE users.id = #{user.id}
      ))
    end
  end

  def down
    remove_index :users, :jti_token
    remove_column :users, :jti_token
  end
end
