# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Class maintains & manages the player's score. It also prints out the score & secret word.
class ScoreBoard
  using Colorable

  private

  def initialize(secret_word)
    self.class.secret_word = secret_word
  end

  class << self
    @secret_word = nil
    @score = nil

    attr_accessor :secret_word, :score

    def update(letter = '')
      secret_word.split('').each_with_index do |secret_letter, index|
        score[index] = letter if letter.eql?(secret_letter)
      end
      print_score
    end

    def show_secret_word
      puts ''
      print 'The Mystery word is:'.color(:bright_green)
      secret_word.split('').each { |letter| print "  #{letter.upcase.color(:bright_green)}" }
      puts ''
    end

    private

    def print_score
      puts ''
      score.each_with_index do |letter, index|
        letter = letter.upcase
        print score[index].eql?(secret_word[index]) ? "  #{letter.color(:green)}" : "  #{letter.color(:bright_yellow)}"
      end
      puts ''
    end
  end
end
