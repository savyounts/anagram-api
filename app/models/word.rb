
class Word < ApplicationRecord
  attr_accessor :dictionary_key
  validates :letters, presence: true

  @@dictionary = {}

  def initialize(args)
    super
    @letters = args[:letters]

    # require 'pry'; binding.pry
    # add 'dictionary_key' attr that is lowercase
    self.add_to_dictionary
  end

  def add_to_dictionary
    if @@dictionary[self.dictionary_key]
     @@dictionary[self.dictionary_key].include?(self.letters) ? nil : @@dictionary[self.dictionary_key] << self.letters
    else
     @@dictionary[self.dictionary_key] = [self.letters]
    end
  end

  def dictionary_key
    self.letters.chars.sort.join
  end

  def self.dictionary
    @@dictionary
  end



  def find_anagrams(limit = nil)
    anagrams = []
    @@dictionary[self.dictionary_key].each { |word| anagrams << word unless word == self.letters } if @@dictionary[self.dictionary_key]
    limit ? anagrams.take(limit.to_i) : anagrams
  end

end
