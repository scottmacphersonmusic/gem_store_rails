# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create(
  name: 'Diamond',
  description: 'real shiny',
  price: 1_000.00,
  rarity: 6,
  color: 'clear',
  faces: 17
);

Product.create(
  name: 'Onyx',
  description: 'an excellent gem',
  price: 400.00,
  rarity: 4,
  color: 'grey',
  faces: 9
);
