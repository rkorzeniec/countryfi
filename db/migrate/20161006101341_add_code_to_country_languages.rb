# frozen_string_literal: true

class AddCodeToCountryLanguages < ActiveRecord::Migration[4.2]
  def change
    add_column :country_languages, :code, :string
  end
end
