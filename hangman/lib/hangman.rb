# frozen_string_literal: true

require_relative 'prologue/prologue'
require_relative 'select_game/select_game'
require_relative 'result/result'
require_relative './save_game/save_game'
require_relative './another_round/another_round'

# This Class controls the flow of the game. It creates instances from other classes.
class Hangman
  private

  attr_accessor :lives, :score_board, :guess
  attr_reader :secret_word, :load_game, :game_type

  def initialize(introduction, game_data)
    @introduction = introduction.commence
    @load_game = game_data.new.load_game
    @secret_word = load_game[:secret_code]
    @score_board = load_game[:score_board]
    @lives = load_game[:lives]
    @guess = load_game[:guess]
    @game_type = load_game[:type]
  end

  def new_game?
    game_type.downcase.include?('new')
  end

  def lost?
    lives <= 0
  end

  def won?
    secret_word == score_board.score.join
  end

  def save_file
    @game_saved = true
    SaveGame.add_data({ secret_word: secret_word, score: score_board.score, lives: lives, guess_logs: guess.logs })
  end

  def validate_choice(choice)
    secret_word.include?(choice) ? correct_guess(choice) : incorrect_guess
  end

  def correct_guess(choice)
    Result.correct_guess(choice)
  end

  def incorrect_guess
    @lives -= 1
    Result.incorrect_guess(lives.to_s)
  end

  def game_concluded
    won? ? player_won : player_lost
  end

  def player_won
    Result.won
    SaveGame.remove_data unless new_game?
  end

  def player_lost
    Result.lost
    score_board.show_secret_word
    SaveGame.remove_data unless new_game?
  end

  public

  def start_game
    score_board.update

    until lost? || won?
      choice = guess.current_guess

      break save_file if choice.eql?('save')

      score_board.update(choice)
      validate_choice(choice)
      game_concluded if lost? || won?
    end
  end

  attr_reader :game_saved
end

loop do
  new_game = Hangman.new(Prologue.new, SelectGame)
  new_game.start_game
  break if new_game.game_saved
  break unless AnotherRound.play?
end
