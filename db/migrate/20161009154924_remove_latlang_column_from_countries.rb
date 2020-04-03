class RemoveLatlangColumnFromCountries < ActiveRecord::Migration[4.2]
  def change
    remove_column :countries, :latlang, :string
  end
end
