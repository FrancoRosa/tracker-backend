FactoryBot.define do
  factory :track do
    name { Faker::Lorem.word }
    user_id nil
  end
end