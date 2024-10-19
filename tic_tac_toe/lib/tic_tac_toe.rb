# frozen_string_literal: true

require_relative 'play_round'

# This is the starter class for this application. It creates instances from the 'PlayRound' class.
# It keeps on creating instances & discarding it and stops if the player agrees to 'quit' the game.
class TicTacToe
  def initialize
    loop do
      new_game_instance = PlayRound.new
      next if new_game_instance.play_next_round?

      break
    end
  end
end

TicTacToe.new
