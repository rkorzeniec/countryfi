# frozen_string_literal: true

class RemoveDemonymsColumnFromCountries < ActiveRecord::Migration[6.0]
  def change
    remove_column :countries, :demonym, :string
  end
end
