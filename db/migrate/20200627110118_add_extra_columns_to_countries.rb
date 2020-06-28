# frozen_string_literal: true

class AddExtraColumnsToCountries < ActiveRecord::Migration[6.0]
  def change
    change_table :countries, bulk: true do |t|
      t.column :independent, :boolean, deafault: true, after: :area
      t.column :status, :string, after: :independent, limit: 50
      t.column :flag, :string, after: :status
    end
  end
end
