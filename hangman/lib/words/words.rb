# frozen_string_literal: true

require_relative 'dictionary'

# This Class chooses a 'Random Word' from an array full of words.
class Words
  private

  attr_reader :list_of_words

  def initialize(words_list: Dictionary.new)
    @list_of_words = words_list.words
    generate_random_word
  end

  def generate_random_word
    @random = list_of_words.sample
    @random = list_of_words.sample until @random.length.between?(5, 12)
  end

  public

  attr_reader :random
end
