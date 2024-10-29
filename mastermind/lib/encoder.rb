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

  attr_reader :secret_color_code, :all_color_codes
  attr_accessor :guess_history, :score_history, :current_feedback, :guess, :max_guess

  def initialize
    colors_code = WorstCase.new
    @all_color_codes = colors_code.all_possibilities
    @secret_color_code = all_color_codes.to_a.sample
    @guess = 1
    @max_guess = 12
    @guess_history = []
    @score_history = []
    @current_feedback = ''
  end

  def start_guessing
    while guess <= max_guess
      current_guess = enter_valid_guess
      guess += 1
      result = determine_win_or_lose?(current_guess)
      break if result

      update_feedback(current_feedback)
    end
  end

  def enter_valid_guess
    current_guess = make_player_to_guess
    current_guess = notify_invalid_guess until valid_guess?(current_guess)
    current_guess
  end

  def valid_guess?(guessed_code)
    all_color_codes.include?(guessed_code)
  end

  def determine_win_or_lose?(guess)
    current_feedback = generate_score(guess)
    match_won = won?(current_feedback)
    player_is_won if match_won
    match_lost = lost?
    player_is_lost if match_lost
    match_won || match_lost
  end

  def won?(score)
    score.eql?('BBBB')
  end

  def lost?
    guess > max_guess
  end

  def generate_score(guessed_code)
    score = outcome_of_the_guess(guessed_code, secret_color_code)
    update_history(guessed_code, score)
    score
  end

  def update_history(guessed_code, response_of_the_guess)
    guess_in_colors = convert_code_to_colors(guessed_code)
    response_of_the_guess = response_of_the_guess.chars
    guess_history << guess_in_colors
    score_history << response_of_the_guess
  end
end
