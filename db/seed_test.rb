require "json"
require "open-uri"

url = "https://randomuser.me/api/?results=30&nat=br"
user_serialized = URI.open(url).read
users = JSON.parse(user_serialized)

users['results'].each do |user|
  puts user['name']['first']
  puts user['name']['last']
  puts user['gender']
  puts user['email']
  puts user['picture']['medium']
  p
end
