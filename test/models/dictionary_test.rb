require_relative '../test_helper'

class DictionaryTest < ActiveSupport::TestCase

  def test_dicitonary_initialized_with_empty_hash_and_language
    dictionary = Dictionary.new(language:"english")
    assert_equal dictionary.hash, {}
    assert_equal dictionary.language, "english"
  end
end
