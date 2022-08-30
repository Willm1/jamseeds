require 'faker'

puts "Creating database"
# generate 30 users

30.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    postcode: Faker::Address.zip_code,
    dob: Faker::Date.birthday(min_age: 18),
    ability: rand(1..3),
    image_url: Faker::Avatar.image,
    password: "password",
    password_confirmation: "password"
  )
end

puts "finished creating database"
