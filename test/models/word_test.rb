require_relative '../test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    @word = Word.create(letters:"read")
  end

  def test_word_initizlied_with_an_empty_array_of_anagrams
    assert_equal "read", @word.letters
    assert_equal [], @word.anagrams
  end

  def test_word_without_letters_not_valid
    word = Word.new
    assert word.invalid?
  end

  def test_sorted_sorts_word
    assert_equal @word.sorted, "ader"
  end

  def test_anagrams_returns_its_anagrams
    dear = Word.create(letters:'dear')
    dare = Word.create(letters:'dare')
    assert_equal @word.anagrams, ["dear", "dare"]
  end

  def test_find_anagrams_returns_array_of_anagrams
    dear = Word.create(letters:'dear')
    dare = Word.create(letters:'dare')
    assert_equal @word.find_anagrams, ["dear", "dare"]
  end

  def test_words_added_to_dictionary
    # write meeeee
  end

end
