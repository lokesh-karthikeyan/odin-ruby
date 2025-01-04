# frozen_string_literal: true

require_relative 'prelude/prelude'
require_relative 'player/player'
require_relative 'conditions_to_win/conditions_to_win'
require_relative 'game_board/game_board'
require_relative 'game/game'

# Factory class that creates instances of other classes.
class GameFactory
  class << self
    def create_prelude = Prelude.new

    def create_player(id, name, marker) = Player.new(id, name, marker)

    def create_win_conditions = ConditionsToWin.new

    def create_game_board(win_conditions) = GameBoard.new(win_conditions)

    def create_game(player1, player2, game_board) = Game.new(player1, player2, game_board)
  end
end
