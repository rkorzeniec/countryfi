class AddLatitudeLongitudeToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :latitude, :decimal, default: 0
    add_column :countries, :longitude, :decimal, default: 0
  end
end
