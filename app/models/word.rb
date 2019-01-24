
class Word < ApplicationRecord

  validates :letters, presence: true
  validates :letters, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  # validates :letters, uniqueness: { message:
  #    "this word is already in our dictionary" }

  def initialize(args)
    key = args[:letters].downcase.chars.sort.join
    args[:dictionary_key] = key
    super
  end

  def find_anagrams(limit = nil)
    anagrams = Word.where(:dictionary_key => self.dictionary_key).pluck(:letters).without(self.letters)
    limit ? (anagrams.take(limit.to_i)) : anagrams
  end

  def self.max_key_length
    sorted = Word.all.max_by{ |word| word.dictionary_key.length }
    sorted ? sorted.letters.length : 0
  end

  def self.min_key_length
    sorted = Word.all.min_by{ |word| word.dictionary_key.length }
    sorted ? sorted.letters.length : 0
  end

  def self.avg_word_length
    return if Word.all.empty?
    all_words = Word.all
    avg = all_words.inject(0.0) { |sum, word| sum + word.letters.length } / all_words.size.to_f
    avg.round
  end

  def self.dictionary_stats
    { word_count: self.all.count,
      max_word_length: self.max_key_length,
      min_word_lenth: self.min_key_length,
      average_word_length: self.avg_word_length
    }
  end

  def self.delete_all(word)
    words = self.where(:dictionary_key => word.dictionary_key)
    words.destroy_all

  end


end
