FactoryGirl.define do
  pw = RandomData.random_sentence
  factory :user do
    name RandomData.random_name
    email  "test123@email.com"
    password pw
    password_confirmation pw
    role :standard
  end
end
