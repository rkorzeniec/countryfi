class AddCallingCodeToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :callingCode, :string, after: :currency
  end
end
