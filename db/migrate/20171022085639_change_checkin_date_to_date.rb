# frozen_string_literal: true

class ChangeCheckinDateToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :checkins, :checkin_date, :date # rubocop:todo Rails/ReversibleMigration
  end
end
