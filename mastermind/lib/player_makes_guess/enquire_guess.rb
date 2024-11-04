# frozen_string_literal: true

require_relative '../color_codes'
require_relative '../colored_text'

# This Class has methods to ask a guess from a player.
class EnquireGuess
  private

  include ColorCodes
  using ColoredText

  def initialize(possibilities)
    @possibilities = possibilities
  end

  def valid_guess?(guess)
    @possibilities.include?(guess)
  end

  def to_color_codes(guess)
    guess_of_colors = guess.tr(' ', '').downcase.split(',')
    guess_of_colors.map! do |color|
      color_of_a_code[color]
    end
    guess_of_colors.join
  end

  def print_enter_guess(guess, max_guess)
    print "Enter your guess (#{guess}/#{max_guess}): ".color_it('light_cyan')
    to_color_codes(gets.chomp)
  end

  def print_invalid_guess(guess, max_guess)
    puts 'Invalid guess!!! Make a valid guess as per the format with the available colors.'.color_it('red')
    puts ''
    print_enter_guess(guess, max_guess)
  end

  public

  def enter_guess(guess, max_guess)
    guess_code = print_enter_guess(guess, max_guess)
    guess_code = print_invalid_guess(guess, max_guess) until valid_guess?(guess_code)
    guess_code
  end
end
