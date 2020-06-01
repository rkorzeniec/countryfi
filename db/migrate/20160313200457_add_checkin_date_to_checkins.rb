# frozen_string_literal: true

class AddCheckinDateToCheckins < ActiveRecord::Migration[4.2]
  def change
    add_column :checkins, :checkin_date, :datetime
  end
end
