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

# add profile background image urls to array
bg_imgs = []

bg_imgs << "https://images.pexels.com/photos/1114690/pexels-photo-1114690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/4004374/pexels-photo-4004374.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/144429/pexels-photo-144429.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/995301/pexels-photo-995301.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/33597/guitar-classical-guitar-acoustic-guitar-electric-guitar.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/5193525/pexels-photo-5193525.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/5485944/pexels-photo-5485944.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/1389429/pexels-photo-1389429.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/89909/pexels-photo-89909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"

bg_imgs << "https://images.pexels.com/photos/8044198/pexels-photo-8044198.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/9010104/pexels-photo-9010104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/2422915/pexels-photo-2422915.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/40896/larch-conifer-cone-branch-tree-40896.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/132474/pexels-photo-132474.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/913416/pexels-photo-913416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/2531608/pexels-photo-2531608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/807598/pexels-photo-807598.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/2584055/pexels-photo-2584055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/196652/pexels-photo-196652.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"

bg_imgs << "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/3812950/pexels-photo-3812950.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/4065806/pexels-photo-4065806.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/1047940/pexels-photo-1047940.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/33779/hand-microphone-mic-hold.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/1550469/pexels-photo-1550469.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/210764/pexels-photo-210764.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/3544128/pexels-photo-3544128.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/7503461/pexels-photo-7503461.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
bg_imgs << "https://images.pexels.com/photos/51932/rotary-valves-tuba-valves-stimmzug-51932.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"

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

# Shuffle profile background images
bg_imgs.shuffle
img_counter = 0

user_seeds['results'].each do |user_seed|
  user = User.create!(first_name: user_seed['name']['first'],
                      last_name: user_seed['name']['last'],
                      email: user_seed['email'],
                      city: ["Lisboa", "Porto", "Faro", "Sagres", "Braga"].sample,
                      postcode: Faker::Address.zip_code,
                      country: "Portugal",
                      dob: Faker::Date.birthday(min_age: 18),
                      gender: user_seed['gender'],
                      ability: rand(1..3),
                      bio: Faker::Lorem.sentence(word_count: 75),
                      profile_img_url: user_seed['picture']['medium'],
                      banner_img_url: bg_imgs[img_counter],
                      password: "password",
                      password_confirmation: "password")

  img_counter += 1

  # Add random instruments to the user
  instruments_num = (1..instruments.size - 1).to_a.sample
  user.instruments << instruments.sample(instruments_num)

  genres_num = (1..genres.size - 1).to_a.sample
  user.genres << genres.sample(genres_num)
end

# Create users for chatroom testing
User.create!(
  first_name: "Leith",
  last_name: "Atia",
  email: "leith@dolls.com",
  city: "Lisboa",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: Faker::Lorem.sentence(word_count: 75),
  profile_img_url: "data:image/jpeg;base64,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",
  banner_img_url: "https://images.pexels.com/photos/346726/pexels-photo-346726.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
  profile_img_url: "data:image/jpeg;base64,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",
  banner_img_url: "https://images.pexels.com/photos/3807838/pexels-photo-3807838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
  profile_img_url: "https://static.wikia.nocookie.net/seinfeld/images/7/76/George-costanza.jpg/revision/latest/top-crop/width/360/height/360?cb=20110406222711",
  banner_img_url: "https://images.pexels.com/photos/2254140/pexels-photo-2254140.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  password: "password",
  password_confirmation: "password"
)

puts "Creating chatrooms"
Chatroom.create!(name: "general", group: false)

puts "finished creating database"
