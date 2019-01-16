# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

File.open('dictionary.txt', 'r').each do |word|
  new_word=Word.create(letters: word.chomp)
  puts "creating #{word}" if new_word.persisted?
end
