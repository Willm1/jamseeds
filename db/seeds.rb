require 'faker'

UserInstrument.destroy_all
UserGenre.destroy_all
User.destroy_all

puts "Creating database"
# generate 30 users


30.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    city: "Lisboa",
    postcode: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    dob: Faker::Date.birthday(min_age: 18),
    ability: rand(1..3),
    image_url: Faker::Avatar.image,
    password: "password",
    password_confirmation: "password"
  )
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
  image_url: Faker::Avatar.image,
  password: "password",
  password_confirmation: "password"
)

puts "finished creating database"
