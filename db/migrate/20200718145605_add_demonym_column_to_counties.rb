# frozen_string_literal: true

class AddDemonymColumnToCounties < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :demonym, :string, after: :area
  end
end
