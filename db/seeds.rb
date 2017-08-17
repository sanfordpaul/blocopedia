# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'
require 'faker'

# Create Users
5.times do
  User.create!(
  name:     Faker::Name.name,
  email:    Faker::Internet.email,
  password: Faker::Internet.password(6, 12, true),
  role: [:standard, :premium].sample
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@user.com',
  password: 'password',
  role:     :admin
)

# Create a member
member = User.create!(
  name:     'Premium User',
  email:    'premium@user.com',
  password: 'password',
  role: :premium
)

users = User.all

25.times do
  fake_title = String.new
  fake_body = String.new
  3.times do
    fake_title << Faker::StarWars.vehicle + " "
  end
  (5..10).to_a.sample.times do
    fake_body << Faker::StarWars.quote + " "
  end
  user = users.sample

  Wiki.create!(
    user_id: user.id,
    title:  fake_title,
    body:   fake_body,
    private: [true, false].sample
  )

wikis = Wiki.all

  Collaboration.create!(
  user: users.sample,
  wiki: wikis.sample
  )

end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaboration.count} collaborations created"
