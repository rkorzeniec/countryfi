FactoryBot.define do
  factory :checkin do
    user
    country
    checkin_date { Time.zone.today }

    trait :visited do
      checkin_date { Time.zone.today - 1.day }
    end
  end
end
