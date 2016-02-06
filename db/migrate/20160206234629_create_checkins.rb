class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :country, foreign_key: true

      t.timestamps null: true
    end
  end
end
