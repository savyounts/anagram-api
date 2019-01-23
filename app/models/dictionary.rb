class Dictionary < ApplicationRecord
  has_many :words
  @@dictionaries = {}

  def initialize(args)
    super
    @lang =  args[:lang]
    @hash = {}
  end

  def hash
    @hash ||= {}
  end

  def add_word_to_hash(word:, key:)
    self.hash
    if @hash[key]
      @hash[key].include?(word) ? nil : @hash[key] << word
    else
      @hash[key] = [word]
    end
  end

def add_all_words_to_hash
  #Word.all.each{ |word| word.add_word_to_hash if word.lang === self.lang}
end

  # Query methods
  def find_anagrams(word:, key:, limit: nil)
    anagrams = self.hash[key].without(word)
    limit ? (anagrams.take(limit.to_i)) : anagrams
  end

  def max_key_length
    max = self.hash.max_by{ |key, value| key.length }.last
    max[0].length
  end

  def min_key_length
    max = self.hash.min_by{ |key, value| key.length }
    max[0].length
  end

  def avg_word_length
    all_words = self.words
    avg = all_words.inject(0.0) { |sum, word| sum + word.letters.length } / all_words.size
    avg.to_i
  end

  def dictionary_stats
    { word_count: self.words.count,
      max_word_length: self.max_key_length,
      min_word_lenth: self.min_key_length,
      average_word_length: self.avg_word_length
    }
  end

  # Class Methods

  def self.get_dictionary(lang)
    self.find_by(lang: lang)
  end


end
