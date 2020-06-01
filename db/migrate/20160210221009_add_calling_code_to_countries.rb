# frozen_string_literal: true

class AddCallingCodeToCountries < ActiveRecord::Migration[4.2]
  def change
    add_column :countries, :callingCode, :string, after: :currency
  end
end
