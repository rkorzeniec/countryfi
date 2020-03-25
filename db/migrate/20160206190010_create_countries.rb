class CreateCountries < ActiveRecord::Migration[4.2]
  def up
    create_table :countries do |t|
      t.string :name_common
      t.string :name_official
      t.text :name_native
      t.string :tld
      t.string :cca2
      t.string :ccn3
      t.string :cca3
      t.string :cioc
      t.string :currency
      t.string :capital
      t.text :altSpellings
      t.string :region
      t.string :subregion
      t.text :languages
      t.text :translations
      t.string :latlang
      t.string :demonym
      t.boolean :landlocked
      t.text :borders
      t.float :area

      t.timestamps null: false
    end
  end

  def down
    drop_table :countries
  end
end
