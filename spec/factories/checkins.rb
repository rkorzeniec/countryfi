FactoryGirl.define do
  factory :plain_checkin do
    user_id 1
    country_id 1
    checkin_date Time.zone.now
  end

  factory :checkin do
    user
    country
    checkin_date Time.zone.now
  end
end
