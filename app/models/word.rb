
class Word < ApplicationRecord
  attr_accessor :dictionary_key

  validates :letters, presence: true
  validates :letters, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  # validates :letters, uniqueness: { message:
  #    "this word is already in our dictionary" }

  @@dictionary = {}

  def initialize(args)
    super
    @letters = args[:letters]
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
    self.letters.downcase.chars.sort.join
  end

  def find_anagrams(limit = nil)
    anagrams = []
    @@dictionary[self.dictionary_key].each { |word| anagrams << word unless word == self.letters } if @@dictionary[self.dictionary_key]
    limit ? anagrams.take(limit.to_i) : anagrams
  end

# Class Methods
  def self.dictionary
    @@dictionary
  end

  def self.max_key_length(dictionary)
    sorted = dictionary.max_by{ |key, value| key.length }.last
    sorted[0].length
  end

  def self.min_key_length(dictionary)
    sorted = dictionary.min_by{ |key, value| key.length }
    sorted[0].length
  end

  def self.avg_word_length
    all_words = Word.all
    avg = all_words.inject(0.0) { |sum, word| sum + word.letters.length } / all_words.size
    avg.to_i
  end

  def self.dictionary_stats(dictionary)
    { word_count: self.all.count, 
      max_word_length: self.max_key_length(dictionary),
      min_word_lenth: self.min_key_length(dictionary),
      average_word_length: self.avg_word_length
    }
  end


end
