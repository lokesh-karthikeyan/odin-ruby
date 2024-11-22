# frozen_string_literal: true

require_relative '../words/words'
require_relative '../score_board/score_board'
require_relative '../guess/guess'

# It's a 'Super Class' for the 'NewGame' and 'ResumeGame'.
class Game
  def secret_word
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def score_board
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def lives
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def type
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def guess
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# This Class has information about the 'Data' for a 'New Game'.
class NewGame < Game
  def secret_word
    @secret_word = Words.new.random
  end

  def score_board
    ScoreBoard.new(@secret_word)
    ScoreBoard.score = ['_'] * @secret_word.length
    ScoreBoard
  end

  def lives
    8
  end

  def type
    self.class.name
  end

  def guess
    Guess.logs = []
    Guess
  end
end

# This Class has information about the 'Data' to load a 'Saved Game'.
class ResumeGame < Game
  private

  def initialize
    super
    return unless File.exist?('game_data/resume_game.json')

    @json_file = File.read('game_data/resume_game.json')
    @game_data = JSON.parse(@json_file).transform_keys(&:to_sym)
  end

  attr_reader :game_data

  public

  def secret_word
    game_data[:secret_word]
  end

  def score_board
    ScoreBoard.new(secret_word)
    ScoreBoard.score = game_data[:score]
    ScoreBoard
  end

  def lives
    game_data[:lives]
  end

  def type
    self.class.name
  end

  def guess
    Guess.logs = game_data[:guess_logs]
    Guess
  end
end
