FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    member { Faker::Lorem.characters(number: 20) }
    password { Faker::Lorem.characters(number: 6) }

    after(:create) do |user|
      create_list(:studio_user, 1,id:Faker::Number.between(from: 1) , user: user, studio_id: 1)
    end
  end
end
