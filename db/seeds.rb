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
  price: 500,
  description:'サンプルサンプル' 
)

item.image.attach(io: File.open(Rails.root.join('app/assets/images/dummy.jpg')),
                  filename: 'dummy.jpg')

item2 = Item.create!(
    name: 'プロテインバーいちご',
    price: 200,
    description: 'サンプルサンプル2'
  )

item2.image.attach(io: File.open(Rails.root.join('app/assets/images/dummy.jpg')),
                  filename: 'dummy.jpg')

item3 = Item.create!(
  name: 'プロテインバーチョコレート',
  price: 500,
  description: 'サンプルサンプル3'
)

item3.image.attach(io: File.open(Rails.root.join('app/assets/images/dummy.jpg')),
                filename: 'dummy.jpg')
