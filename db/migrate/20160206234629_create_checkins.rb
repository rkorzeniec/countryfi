# frozen_string_literal: true

class CreateCheckins < ActiveRecord::Migration[4.2]
  def change
    create_table :checkins do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :country, foreign_key: true

      t.timestamps null: true
    end
  end
end
