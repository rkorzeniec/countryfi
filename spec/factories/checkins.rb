FactoryGirl.define do
  factory :checkin do
    user_id 1
    country_id 1
    checkin_date Time.zone.now
  end
end
