# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'
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
  wiki = Wiki.create!(
    user:   users.sample,
    title:  Faker::StarWars.quote,
    body:   Faker::StarWars.wookie_sentence + ' ' +Faker::StarWars.quote + ' ' + Faker::StarWars.vehicle,
    private: [true, false].sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
