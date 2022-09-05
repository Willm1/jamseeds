require 'faker'

puts "Destroying entries"
Chatroom.destroy_all
UserInstrument.destroy_all
UserGenre.destroy_all
User.destroy_all
Instrument.destroy_all

puts "Creating database"
# generate 30 users

instruments = %w[Guitar Vocals Violin Piano Trumpet].map do |name|
  Instrument.create!(name:)
end
genres = []
%w[Pop Classical Metal Jazz Indie].each do |name|
  genres << Genre.create!(name:)
end

30.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    city: ["Lisboa", "Porto", "Faro", "Sagres", "Braga"].sample,
    postcode: Faker::Address.zip_code,
    country: Faker::Address.country,
    dob: Faker::Date.birthday(min_age: 18),
    ability: rand(1..3),
    bio: Faker::Lorem.sentence(word_count: 35),
    image_url: Faker::Avatar.image,
    password: "password",
    password_confirmation: "password"
  )

  # Add random instruments to the user
  instruments_num = (1..instruments.size - 1).to_a.sample
  user.instruments << instruments.sample(instruments_num)

  genres_num = (1..genres.size - 1).to_a.sample
  user.genres << genres.sample(genres_num)
end

# Create 2 users for chatroom testing
User.create!(
  first_name: "Leith",
  last_name: "Atia",
  email: "leith@dolls.com",
  city: "Lisboa",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: Faker::Lorem.sentence(word_count: 75),
  image_url: Faker::Avatar.image,
  password: "password",
  password_confirmation: "password"
)

User.create!(
  first_name: "Jim",
  last_name: "Bob",
  email: "jim@dolls.com",
  city: "Lisboa",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: Faker::Lorem.sentence(word_count: 75),
  image_url: Faker::Avatar.image,
  password: "password",
  password_confirmation: "password"
)

User.create!(
  first_name: "George",
  last_name: "Constanza",
  email: "George@dolls.com",
  city: "Lisboa",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: Faker::Lorem.sentence(word_count: 75),
  image_url: Faker::Avatar.image,
  password: "password",
  password_confirmation: "password"
)

puts "Creating chatroom"
Chatroom.create!(name: "general", group: false)

puts "finished creating database"
