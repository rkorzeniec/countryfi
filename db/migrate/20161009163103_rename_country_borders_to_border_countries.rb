# frozen_string_literal: true

class RenameCountryBordersToBorderCountries < ActiveRecord::Migration[4.2]
  def change
    rename_table :country_borders, :border_countries
  end
end
