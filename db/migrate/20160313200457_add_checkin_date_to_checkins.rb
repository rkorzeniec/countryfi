class AddCheckinDateToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :checkin_date, :datetime
  end
end
