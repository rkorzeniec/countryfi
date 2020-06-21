# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, foreign_key: true, null: false, type: :integer
      t.references :notifiable, polymorphic: true, null: false
      t.datetime :read_at, null: true
      t.timestamps null: true
    end
  end
end
