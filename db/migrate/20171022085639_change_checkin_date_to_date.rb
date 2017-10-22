class ChangeCheckinDateToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :checkins, :checkin_date, :date
  end
end
