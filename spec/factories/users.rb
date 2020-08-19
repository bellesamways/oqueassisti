FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { 'foo123bar' }
  end
end
