
class Word < ApplicationRecord
  validates :letters, presence: true

  @@dictionary = {}

  def initialize(letters)
    super
    @letters = letters
    @anagrams = []
    # require 'pry'; binding.pry
    # add 'dictionary_key' attr that is lowercase
    self.add_to_dictionary
  end

  def add_to_dictionary
    if @@dictionary[self.sorted]
     @@dictionary[self.sorted].include?(self.letters) ? nil : @@dictionary[self.sorted] << self.letters
     puts "added to dictionary"
    else
     @@dictionary[self.sorted] = [self.letters]
     puts "added to dictionary"

    end
  end

  def self.dicitonary
    @@dictionary
  end

  # def dictionary_key
  #   @@dictionary[self.sorted]
  # end

  def sorted
    self.letters.chars.sort.join
  end

  def my_anagrams
    self.anagrams.empty? ? self.find_anagrams : self.anagrams
  end

  def find_anagrams
    anagrams = self.anagrams
    if @@dictionary[self.sorted]
      @@dictionary[self.sorted].each do |word|
        if word != self.letters
          anagrams << word
        end
      end
    end
    anagrams || "sorry, no anagrams for this word"
  end

end
