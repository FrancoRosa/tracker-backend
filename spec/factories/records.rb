FactoryBot.define do
  factory :record do
    value { Faker::Number.positive }
    track_id { nil }
  end
end