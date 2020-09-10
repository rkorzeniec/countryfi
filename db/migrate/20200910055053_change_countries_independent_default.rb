# frozen_string_literal: true

class ChangeCountriesIndependentDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:countries, :independent, from: true, to: false)
  end
end
