# frozen_string_literal: true

require_relative 'algorithms/knuth_worst_case'
require_relative 'terminal/terminal_messages'
require_relative 'feedback'
require_relative 'terminal/convert_to_symbols'

# Here, the computer generates a random color combo as a secret code. It acts as an encoder.
# Players has to guess the secret code within the number of available guesses.
class Encoder
  private

  include TerminalMessages
  include Feedback
  include ConvertToSymbols

  attr_reader :secret_color_code, :all_color_codes, :max_guess
  attr_accessor :guess_history, :score_history, :current_feedback, :guess

  def initialize
    colors_code = WorstCase.new
    @all_color_codes = colors_code.all_possibilities
    @secret_color_code = all_color_codes.to_a.sample
    @guess = 1
    @max_guess = 12
    @guess_history = []
    @score_history = []
    @current_feedback = ''
    introduction
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
    @current_feedback = generate_score(guess)
    match_won = won?(current_feedback)
    player_is_won if match_won
    match_lost = lost?
    player_is_lost if match_lost && match_won == false
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
    colored_color_symbol = color_to_colored_symbol(guess_in_colors)
    colored_score_symbol = score_to_colored_symbols(response_of_the_guess)
    @guess_history << colored_color_symbol
    @score_history << colored_score_symbol
  end

  public

  def start_guessing
    while guess <= max_guess
      current_guess = enter_valid_guess
      @guess += 1
      result = determine_win_or_lose?(current_guess)
      break if result

      update_feedback(current_feedback)
    end
  end
end
