class AddCountryCallingCodesTable < ActiveRecord::Migration
  def change
    create_table :country_calling_codes do |t|
      t.belongs_to :country, foreign_key: true
      t.string :calling_code

      t.timestamps
    end
  end
end
