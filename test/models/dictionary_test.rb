require_relative '../test_helper'

class DictionaryTest < ActiveSupport::TestCase

  def test_dicitonary_initialized_with_empty_hash
    dictionary = Dictionary.new
    assert_equal dictionary.hash, {}
  end
end
