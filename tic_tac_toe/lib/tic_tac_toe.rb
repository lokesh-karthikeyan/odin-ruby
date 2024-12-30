# frozen_string_literal: true

require_relative 'play_round'

# This is the starter class for this application. It creates instances from the 'PlayRound' class.
# It keeps on creating instances & discarding it and stops if the player agrees to 'quit' the game.
class TicTacToe
  def initialize
    loop do
      new_game_instance = PlayRound.new
      new_game_instance.show_starter_details
      new_game_instance.inquire_player_details
      new_game_instance.start_game

      next if new_game_instance.continue_game?

      break
    end
  end
end

TicTacToe.new
