FactoryBot.define do
  factory :checkin do
    user
    country
    checkin_date Time.current

    trait :visited do
      checkin_date Time.current - 1.day
    end
  end
end
