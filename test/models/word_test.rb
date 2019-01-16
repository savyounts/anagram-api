require_relative '../test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    Word.dictionary.clear
    @word = Word.create(letters:"cat")
  end

  def test_word_with_letters_is_valid
    assert_equal "cat", @word.letters
    assert_equal "act", @word.dictionary_key
  end

  def test_word_with_letters_is_invalid
    number = Word.new(letters:'123')
    assert number.invalid?
  end

# Works when you can use the uniqueness validator
  # def test_cant_add_same_word_twice
  #   cat2 = Word.new(letters: "cat")
  #   assert cat2.invalid?
  # end

  def test_dictionary_key_returns_sorted_word_lowercase
    word = Word.new(letters: "ReAd")
    assert_equal word.dictionary_key, "ader"
  end

  def test_words_added_to_dictionary
    word = Word.new(letters: 'Bob')
    word.add_to_dictionary
    assert Word.dictionary['bbo']
  end

  def test_find_anagrams_return_limited_anagrams
    dear = Word.new(letters:'act')
    dare = Word.new(letters:'tac')
    assert_equal @word.find_anagrams(1).count, 1
  end

  def test_find_anagrams_returns_array_of_anagrams
    dear = Word.new(letters:'act').add_to_dictionary
    dare = Word.new(letters:'tac').add_to_dictionary
    assert_equal @word.find_anagrams, ["act", "tac"]
  end

  def test_word_not_added_to_dictionary_twice
    cat = Word.new(letters:'cat')
    cat.add_to_dictionary
    cat.add_to_dictionary
    assert_equal Word.dictionary['act'], ['cat']
  end

end
