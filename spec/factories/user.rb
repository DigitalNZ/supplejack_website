FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    username { Faker::Internet.user_name }
    password "password"
    password_confirmation "password"

    after :create do |user|
      ApiKey.create(attributes_for(:api_key).merge(user_id: user.id))
    end
  end
end
