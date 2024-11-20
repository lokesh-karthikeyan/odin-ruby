# frozen_string_literal: true

# This Class opens the 'File' full of words & puts it in an array.
class Dictionary
  private

  def initialize
    @words = File.read('google-10000-english-no-swears.txt').split
  end

  public

  attr_reader :words
end
