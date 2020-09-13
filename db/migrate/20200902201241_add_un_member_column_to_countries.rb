# frozen_string_literal: true

class AddUnMemberColumnToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :un_member, :boolean, after: :demonym, default: false
  end
end
