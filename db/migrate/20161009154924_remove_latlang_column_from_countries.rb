class RemoveLatlangColumnFromCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :latlang
  end
end
