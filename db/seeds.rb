require 'faker'
require "json"
require "open-uri"

puts "Destroying entries"
Chatroom.destroy_all
UserInstrument.destroy_all
UserGenre.destroy_all
User.destroy_all
Instrument.destroy_all
Chatroom.destroy_all
ChatroomUser.destroy_all

instruments = %w[Guitar Vocals Violin Piano Trumpet].map do |name|
  Instrument.create!(name:)
end

genres = []
%w[Pop Classical Metal Jazz Indie].each do |name|
  genres << Genre.create!(name:)
end

# Get user faker details from API
url = "https://randomuser.me/api/?results=30&nat=br"
user_serialized = URI.open(url).read
user_seeds = JSON.parse(user_serialized)

puts "Creating database"
# generate 30 users

user_seeds['results'].each do |user_seed|
  user = User.create!(first_name: user_seed['name']['first'],
                      last_name: user_seed['name']['last'],
                      email: user_seed['email'],
                      city: ["Lisboa", "Porto", "Faro", "Sagres", "Braga"].sample,
                      postcode: Faker::Address.zip_code,
                      country: "Portugal",
                      dob: Faker::Date.birthday(min_age: 18),
                      ability: rand(1..3),
                      bio: Faker::Lorem.sentence(word_count: 75),
                      profile_img_url: user_seed['picture']['medium'],
                      banner_img_url: "https://source.unsplash.com/random",
                      password: "password",
                      password_confirmation: "password")

  # Add random instruments to the user
  instruments_num = (1..instruments.size - 1).to_a.sample
  user.instruments << instruments.sample(instruments_num)

  genres_num = (1..genres.size - 1).to_a.sample
  user.genres << genres.sample(genres_num)
end

# Create users for chatroom testing
# User.create!(
#   first_name: "Leith",
#   last_name: "Atia",
#   email: "leith@dolls.com",
#   city: "Lisboa",
#   postcode: Faker::Address.zip_code,
#   dob: Faker::Date.birthday(min_age: 18),
#   ability: rand(1..3),
#   bio: Faker::Lorem.sentence(word_count: 75),
#   image_url: Faker::Avatar.image,
#   password: "password",
#   password_confirmation: "password"
# )

# User.create!(
#   first_name: "Jim",
#   last_name: "Bob",
#   email: "jim@dolls.com",
#   city: "Lisboa",
#   postcode: Faker::Address.zip_code,
#   dob: Faker::Date.birthday(min_age: 18),
#   ability: rand(1..3),
#   bio: Faker::Lorem.sentence(word_count: 75),
#   image_url: Faker::Avatar.image,
#   password: "password",
#   password_confirmation: "password"
# )

# User.create!(
#   first_name: "George",
#   last_name: "Constanza",
#   email: "George@dolls.com",
#   city: "Lisboa",
#   postcode: Faker::Address.zip_code,
#   dob: Faker::Date.birthday(min_age: 18),
#   ability: rand(1..3),
#   bio: Faker::Lorem.sentence(word_count: 75),
#   image_url: Faker::Avatar.image,
#   password: "password",
#   password_confirmation: "password"
# )

puts "Creating chatrooms"
Chatroom.create!(name: "general", group: false)

puts "finished creating database"
