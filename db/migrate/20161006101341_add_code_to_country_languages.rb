class AddCodeToCountryLanguages < ActiveRecord::Migration
  def change
    add_column :country_languages, :code, :string
  end
end
