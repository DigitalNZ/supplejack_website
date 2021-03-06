# frozen_string_literal: true

FactoryBot.define do
  factory :api_key do
    token { Faker::Internet.password(8) }
    terms { false }
  end
end
