# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

posts = []
50.times do |n|
  time = Time.current
  posts << {
    user_id: "1",
    room_name: "お部屋#{n+1}",
    room_price: Faker::Number.number(digits: 5),
    room_info: "test",
    room_address_postcode: Faker::Number.number(digits: 7),
    room_address_prefecture: "北海道",
    room_address_town_village: Gimei.address.city.kanji,
    room_address_other: "test",
    room_photo: "78132982.jpg",
    created_at: time,
    updated_at: time
  }
end

Post.insert_all posts
