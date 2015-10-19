# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

diamond = Product.create(
  name: 'Diamond',
  description: 'real shiny',
  price: 1_000.00,
  rarity: 6,
  color: 'clear',
  faces: 17
)

onyx = Product.create(
  name: 'Onyx',
  description: 'an excellent gem',
  price: 400.00,
  rarity: 4,
  color: 'grey',
  faces: 9
)

diamond.reviews.create(
  stars: 3,
  author: 'thedude@lebowski.net',
  body: 'i\'ve seen better'
)

diamond.reviews.create(
  stars: 5,
  author: 'diamondjoe@biden.gov',
  body: 'a truly great gem'
)

onyx.reviews.create(
  stars: 1,
  author: 'guy1@example.com',
  body: 'truly deplorable gem!'
)

onyx.reviews.create(
  stars: 2,
  author: 'guy2@example.com',
  body: 'i\'ll never shop here again'
)
