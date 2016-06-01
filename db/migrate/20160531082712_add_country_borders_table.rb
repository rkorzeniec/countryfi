class AddCountryBordersTable < ActiveRecord::Migration
  def change
    create_table :country_borders do |t|
      t.belongs_to :country, foreign_key: true
      t.integer :border_country_id

      t.timestamps
    end
  end
end
