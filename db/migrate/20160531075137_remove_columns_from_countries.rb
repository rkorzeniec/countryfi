class RemoveColumnsFromCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :name_native
    remove_column :countries, :tld
    remove_column :countries, :currency
    remove_column :countries, :altSpellings
    remove_column :countries, :languages
    remove_column :countries, :translations
    remove_column :countries, :borders
    remove_column :countries, :callingCode
  end
end
