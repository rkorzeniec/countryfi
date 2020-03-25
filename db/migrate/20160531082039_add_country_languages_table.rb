class AddCountryLanguagesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :country_languages do |t|
      t.belongs_to :country, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
