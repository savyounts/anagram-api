
class Word < ApplicationRecord
  attr_accessor :dictionary_key
  belongs_to :dictionary, optional: true

  validates :letters, presence: true
  validates :letters, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  # validates :letters, uniqueness: { message:
  #    "this word is already in our dictionary" }

  # @@dictionary = {}

  def initialize(args)
    dictionary = Dictionary.find_or_create_by(lang: args[:lang])
    args[:dictionary] = dictionary
    super(args)
    @letters = args[:letters]
    @lang = args[:lang]
    dictionary.add_word_to_hash(word:args[:letters], key:self.dictionary_key)
  end

  def dictionary_key
    self.letters.downcase.chars.sort.join
  end

  # def add_to_dictionary
  #   if self.hash[self.dictionary_key]
  #     self.hash[self.dictionary_key].include?(self.letters) ? nil : self.hash[self.dictionary_key] << self.letters
  #   else
  #    self.hash[self.dictionary_key] = [self.letters]
  #   end
  # end

  # def find_anagrams(limit = nil)
  #   anagrams = @@dictionary[self.dictionary_key].without(self.letters)
  #   limit ? (anagrams.take(limit.to_i)) : anagrams
  # end

# Class Methods
  # def self.dictionary
  #   @@dictionary
  # end

  # def self.max_key_length(dictionary)
  #   sorted = dictionary.max_by{ |key, value| key.length }.last
  #   sorted[0].length
  # end
  #
  # def self.min_key_length(dictionary)
  #   sorted = dictionary.min_by{ |key, value| key.length }
  #   sorted[0].length
  # end
  #
  # def self.avg_word_length
  #   all_words = Word.all
  #   avg = all_words.inject(0.0) { |sum, word| sum + word.letters.length } / all_words.size
  #   avg.to_i
  # end
  #
  # def self.dictionary_stats(dictionary)
  #   { word_count: self.all.count,
  #     max_word_length: self.max_key_length(dictionary),
  #     min_word_lenth: self.min_key_length(dictionary),
  #     average_word_length: self.avg_word_length
  #   }
  # end


end
