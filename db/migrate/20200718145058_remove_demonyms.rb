# frozen_string_literal: true

class RemoveDemonyms < ActiveRecord::Migration[6.0]
  def change
    drop_table :demonyms do |t|
      t.references :country, foreign_key: true, index: true, type: :integer
      t.string :locale, limit: 5
      t.string :gender, limit: 5
      t.string :name
      t.timestamps null: true
    end
  end
end
