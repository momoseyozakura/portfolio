FactoryBot.define do
  factory :room_user do
    association :user
    association :talk_room
  end
end
