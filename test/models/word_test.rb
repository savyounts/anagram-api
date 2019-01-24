require_relative '../test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    Word.destroy_all
  end

  def test_word_with_letters_is_valid
    cat = Word.new(letters:"cat")
    assert_equal "cat", cat.letters
    assert_equal "act", cat.dictionary_key
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

  def test_find_anagrams_return_limited_anagrams
    cat = Word.new(letters:"cat")
    Word.create(letters:'act')
    Word.create(letters:'tac')
    assert_equal cat.find_anagrams(1).count, 1
  end

  def test_find_anagrams_returns_array_of_anagrams
    cat = Word.create(letters:"cat")
    Word.create(letters:'act')
    Word.create(letters:'tac')
    assert_equal cat.find_anagrams, ["act", "tac"]
  end
  
  def test_find_max_key_length
    setup_multiple_words
    assert_equal Word.max_key_length, 9
  end

  def test_find_min_key_length
    setup_multiple_words
    assert_equal Word.min_key_length, 3
  end

  def test_find_avg_word_length
    setup_multiple_words
    assert_equal Word.avg_word_length, 6
  end

  def setup_multiple_words
    ['red', 'three', 'seventeen'].each { |word| Word.create(letters:word) }
  end

end
