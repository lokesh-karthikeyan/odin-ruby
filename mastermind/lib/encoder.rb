# frozen_string_literal: true

require_relative 'algorithms/knuth_worst_case'
require_relative 'terminal_messages'
require_relative 'feedback'

# Here, the computer generates a random color combo as a secret code. It acts as an encoder.
# Players has to guess the secret code within the number of available guesses.
class Encoder
  private

  include WorstCase
  include TerminalMessages
  include Feedback

  attr_reader :secret_color_code, :guess_history, :score_history, :all_color_codes

  def initialize
    colors_code = WorstCase.new
    @all_color_codes = colors_code.all_possibilities
    @secret_color_code = all_color_codes.to_a.sample
    @guess = 1
    @max_guess = 12
  end

  def start_guessing
    while guess <= max_guess
      current_guess = make_player_to_guess
      current_guess = notify_invalid_guess until valid_guess?(current_guess)
      guess += 1
      if generate_score(current_guess) == 'BBBB'
        decoder_is_won
        break
      end
    end
  end

  def valid_guess?(guessed_code)
    all_color_codes.include?(guessed_code)
  end

  def decoder_is_won; end

  def generate_score(guessed_code)
    outcome_of_the_guess(guessed_code, secret_color_code)
  end
end
