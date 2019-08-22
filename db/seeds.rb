# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{ name: 'Food' }, { name: 'Drink' }])

Post.create!(title:  "Pizza4P",
             content: "pizza cha ca",
             image_url: "",
             category_id: 1)

9.times do |n|
  title  = Faker::Food.vegetables
  content = Faker::Food.description
  image_url = "https://images.unsplash.com/photo-1541795795328-f073b763494e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
  Post.create!(title:  title,
               content: content,
               image_url: image_url,
               category_id: 1)
end