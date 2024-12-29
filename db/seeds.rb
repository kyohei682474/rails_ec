# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
item = Item.create!(
  name: 'プロテイン',
  price: 500
)

item.image.attach(io: File.open(Rails.root.join('app/assets/images/dummy.jpg')),
                  filename: 'dummy.jpg')
                  
# item.image.attach(io:URI.open("https://mybaket999.s3.ap-northeast-1.amazonaws.com/eixu75y4g40dh0nfz5gb58qwgc2h") )
                  
                  