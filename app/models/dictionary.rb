class Dictionary < ApplicationRecord

  def initialize(language)
    super
    @language = language
    @hash = {}
  end

end
