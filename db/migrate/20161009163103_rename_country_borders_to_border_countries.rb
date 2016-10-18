class RenameCountryBordersToBorderCountries < ActiveRecord::Migration
  def change
    rename_table :country_borders, :border_countries
  end
end
