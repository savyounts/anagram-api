class Word < ApplicationRecord
  validates :letters, presence: true

  @@dictionary = {}

  def add_to_dictionary
    if @@dictionary[self.sorted]
     @@dictionary[self.sorted].include?(self.letters) ? @@dictionary[self.sorted] << self.letters : nil
    else
     @@dictionary[self.sorted] = [self.letters]
    end
  end

  def sorted
    self.letters.chars.sort.join
  end

  def anagrams
    @anagrams || "sorry, this word doesn't have any anagrams in our library"
    # @anagrams || self.find_anagrams
  end

  def find_anagrams
    anagram_array = @@dictionary[self.sorted]
    anagram_array.collect {|word| self.anagrams << word unless word == self.letters}
  end

end
