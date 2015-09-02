FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    username { Faker::Internet.user_name }
    password "password"
    password_confirmation "password"

    key {ApiKey.create(token: Faker::Internet.password(8), terms: false)}
  end
end
