# frozen_string_literal: true
class AddCountryBordersTable < ActiveRecord::Migration[4.2]
  def change
    create_table :country_borders do |t|
      t.belongs_to :country, foreign_key: true
      t.integer :border_country_id

      t.timestamps
    end
  end
end
