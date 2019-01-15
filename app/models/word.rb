class Word < ApplicationRecord
  validates :letters, presence: true

  @@dictionary = {}

  def add_to_dictionary(sorted, word)
    if @@dictionary[sorted]
     @@dictionary[sorted].include?(word.letters) ? @@dictionary[sorted] << word.letters : nil
    else
     @@dictionary[sorted] = [word.letters]
    end
  end

  def sorted
    self.letters.chars.sort.join
  end

end
