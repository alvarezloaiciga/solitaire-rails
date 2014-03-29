# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_cards!
  names = %w( A 2 3 4 5 6 7 8 9 10 J Q K)
  suits = %w( hearts clubs spades diamonds )
  especial_cards_values = { A: 1, J: 11, Q: 12, K: 13 }

  return if Card.any?

  suits.each do |suit|
    names.each do |name|
      Card.create(
        suit: suit,
        name: name,
        value: especial_cards_values.fetch(name.to_sym, name.to_i)
      )
    end
  end
end

create_cards!
