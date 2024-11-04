# frozen_string_literal: true

require_relative '../algorithms/possibilities'
require_relative 'enquire_guess'
require_relative 'score'
require_relative '../computer_makes_guess/print_guess'
require_relative '../score_icons'
require_relative '../game_over/game_over'
require_relative 'print_score'

# This Class contains methods in which player enters his / her choice of guesses.
class PlayerMakesGuess
  private

  def initialize
    @possibilities = Possibilities.all_possibilities
    @secret_code = @possibilities.to_a.sample
    @guess = 1
    @max_guess = 12
    @guess_history = []
    @score_history = []
    start_guessing
  end

  def start_guessing
    while @guess <= @max_guess
      current_guess = choose_guess
      current_score = compute_score(current_guess)
      update_logs(current_guess, current_score)
      @guess += 1
      break if win_or_lose?(current_score)

      PrintScore.show(ScoreIcons.new(current_score).score)
    end
  end

  def choose_guess
    ask_guess = EnquireGuess.new(@possibilities)
    ask_guess.enter_guess(@guess, @max_guess)
  end

  def compute_score(guess)
    score = Score.new
    score.calculate(guess, @secret_code)
  end

  def update_logs(guess, score)
    @guess_history << PrintGuess.new(guess).guessed_code
    @score_history << ScoreIcons.new(score).score
  end

  def win_or_lose?(score)
    round_won = score.eql?('BBBB')
    match_won if round_won
    round_lost = @guess > @max_guess && round_won == false
    match_lost if round_lost
    round_won || round_lost
  end

  def match_won
    victory = GameOver.new(@guess)
    victory.player_won(@guess_history, @score_history)
  end

  def match_lost
    defeat = GameOver.new(@guess)
    defeat.player_lost(@secret_code, @guess_history, @score_history)
  end
end
