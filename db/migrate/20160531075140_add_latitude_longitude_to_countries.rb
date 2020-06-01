# frozen_string_literal: true
class AddLatitudeLongitudeToCountries < ActiveRecord::Migration[4.2]
  def change
    # rubocop:disable Rails/BulkChangeTable
    add_column :countries, :latitude, :decimal, default: 0
    add_column :countries, :longitude, :decimal, default: 0
    # rubocop:enable Rails/BulkChangeTable
  end
end
