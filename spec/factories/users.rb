FactoryGirl.define do
  factory :user do
    id 1
    sequence(:email) { |n| "freddie#{n}#{Time.now.to_i}@email.ch" }
    password 'password'
    password_confirmation 'password'
  end
end
