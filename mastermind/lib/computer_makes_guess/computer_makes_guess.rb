# frozen_string_literal: true

require_relative 'knuth_algorithm'
require_relative 'print_guess'
require_relative 'enquire_feedback'
require_relative 'outcome'
require_relative '../game_over/game_over'
require_relative 'score_icons'

# This Class contains methods in which computer makes guesses based on algorithms.
class ComputerMakesGuess
  def initialize
    @guess = 1
    @max_guess = 12
    @guess_history = []
    @score_history = []
    @current_guess = ''
    @current_score = ''
    @guess_by_algorithm = KnuthAlgorithm.new
    start_guessing
  end

  def start_guessing
    while @guess <= @max_guess
      choose_guess
      break if error_occured?

      print_guess
      query_feedback
      update_logs
      @guess += 1
      break if break_condition?
    end
  end

  def choose_guess
    @current_guess = if @guess == 1
                       @guess_by_algorithm.initial_guess
                     else
                       @guess_by_algorithm.next_guess(@current_guess, @current_score)
                     end
  end

  def error_occured?
    GameOver.new(@guess).error_occured if @current_guess.nil?
    @current_guess.nil?
  end

  def print_guess
    print_in_terminal = PrintGuess.new(@current_guess)
    print_in_terminal.my_guess(@guess, @max_guess)
  end

  def query_feedback
    score = EnquireFeedback.new
    score_in_array = score.enquire_pegs_count
    current_score = Outcome.new
    @current_score = current_score.compute(score_in_array)
  end

  def win?
    @current_score == 'BBBB'
  end

  def break_condition?
    is_won = win?
    won if is_won
    is_won
  end

  def update_logs
    @guess_history << PrintGuess.new(@current_guess).guessed_code
    @score_history << ScoreIcons.new(@current_score).score
  end

  def won
    victory = GameOver.new(@guess)
    victory.computer_won(@guess_history, @score_history)
  end
end
