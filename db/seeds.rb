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

# for main instrument seeds
instruments = %w[Guitar Vocals Violin Piano Trumpet].map do |name|
  Instrument.create!(name:)
end

# for individual instrument seed
instrument = Instrument.create(name: "Guitar")

# for main genre seeds
genres = []
%w[Pop Classical Metal Jazz Indie].each do |name|
  genres << Genre.create!(name:)
end

# for individual genre seed
genre = Genre.create(name: "Classical")

# Get user faker details from API
url = "https://randomuser.me/api/?results=30&nat=br"
user_serialized = URI.open(url).read
user_seeds = JSON.parse(user_serialized)

puts "Creating database"
# generate 30 users

user = User.create!(
  first_name: "Pedro",
  last_name: "Ferreira",
  email: "pedro@gmail.com",
  city: "Lisboa",
  gender: "Male",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: "Heeey! My name is George but you can call me Art. Love playing the guitar so hit me up if you wanna make some
        music!",
  profile_img_url: "https://res.cloudinary.com/ds9cwrw2s/image/upload/v1662560514/pedro_penalq.jpg",
  banner_img_url: "https://images.pexels.com/photos/2254140/pexels-photo-2254140.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  password: "password",
  password_confirmation: "password"
)
user.instruments << instrument
user.genres << genre

user = User.create!(
  first_name: "Leith",
  last_name: "Atia",
  email: "leith.atia@gmail.com",
  city: "Lisboa",
  gender: "Male",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: "Hi, I'm currently studying web development and in my free time I enjoy playing the guitar and singing.
        Would love to find someone to jam with or start a band. I love pistachios and horror films!",
  profile_img_url: "https://media-exp1.licdn.com/dms/image/C4E03AQE_fx4TIUanbQ/profile-displayphoto-shrink_200_200/0/1516878852850?e=2147483647&v=beta&t=c2YLkvCFb6CX56Q_fkknGwWSY3ekJaT3ufbY4gYTKoQ",
  banner_img_url: "https://images.pexels.com/photos/346726/pexels-photo-346726.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  password: "password",
  password_confirmation: "password",
)



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
                      bio: [Faker::GreekPhilosophers.quote, Faker::Fantasy::Tolkien.poem, Faker::Hipster.sentences].sample,
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

user = User.create!(
  first_name: "Will",
  last_name: "M",
  email: "will@gmail.com",
  city: "Lisboa",
  gender: "Male",
  postcode: Faker::Address.zip_code,
  dob: Faker::Date.birthday(min_age: 18),
  ability: rand(1..3),
  bio: Faker::Lorem.sentence(word_count: 75),
  profile_img_url: "https://res.cloudinary.com/ds9cwrw2s/image/upload/v1662615478/2330AD07-83F2-41CC-A3C9-0C982889D974_cmqiuf.jpg",
  banner_img_url: "https://images.pexels.com/photos/3807838/pexels-photo-3807838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  password: "password",
  password_confirmation: "password",

)
user.instruments << instrument
user.genres << genre

puts "Creating chatrooms"
Chatroom.create!(name: "general", group: false)

puts "finished creating database"
