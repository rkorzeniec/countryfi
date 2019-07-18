FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "bob#{n}@email.ch" }
    password { 'password' }
    password_confirmation { 'password' }
    jti_token { SecureRandom.base58(4) }
  end
end
