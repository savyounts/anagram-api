# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["dare", "read", "dear", "cat", "act", "bat"].each do |word|
  new_word = Word.create(letters: word)
  new_word.add_to_dictionary
end
