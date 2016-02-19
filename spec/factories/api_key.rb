FactoryGirl.define do
  factory :api_key do
    user

    token { Faker::Internet.password(8) }
    terms false
  end
end
