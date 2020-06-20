# frozen_string_literal: true

class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :message
      t.timestamps null: true
    end
  end
end
