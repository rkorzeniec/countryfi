class RemoveColumnsFromCountries < ActiveRecord::Migration[4.2]
  def change
    # rubocop:disable Rails/BulkChangeTable
    # rubocop:disable Rails/ReversibleMigration
    remove_column :countries, :name_native
    remove_column :countries, :tld
    remove_column :countries, :currency
    remove_column :countries, :altSpellings
    remove_column :countries, :languages
    remove_column :countries, :translations
    remove_column :countries, :borders
    remove_column :countries, :callingCode
    # rubocop:enable Rails/BulkChangeTable
    # rubocop:enable Rails/ReversibleMigration
  end
end
