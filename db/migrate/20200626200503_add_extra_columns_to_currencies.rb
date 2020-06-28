# frozen_string_literal: true

class AddExtraColumnsToCurrencies < ActiveRecord::Migration[6.0]
  def change
    change_table :currencies, bulk: true do |t|
      t.column :symbol, :string, after: :code, limit: 15
      t.column :name, :string, after: :code, limit: 100
    end
  end
end
