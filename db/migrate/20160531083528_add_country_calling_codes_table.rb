# frozen_string_literal: true

class AddCountryCallingCodesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :country_calling_codes do |t|
      t.belongs_to :country, foreign_key: true
      t.string :calling_code

      t.timestamps
    end
  end
end
