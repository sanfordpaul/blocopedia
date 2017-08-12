FactoryGirl.define do
  pw = RandomData.random_sentence
  factory :user do
    name RandomData.random_name
    sequence(:email) { |n| "person#{n}@example.com" }
    password pw
    password_confirmation pw
    role :standard
  end
end
