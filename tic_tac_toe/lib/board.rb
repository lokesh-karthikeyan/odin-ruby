# frozen_string_literal: true

# This class creates an instances of the board & updates it.
class Board
  WINNING_POSSIBILITIES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8],
                           [2, 4, 6]].freeze

  attr_accessor :game_board

  def initialize = self.game_board = Array.new(9, ' ')

  def update_grids(position, character)
    index = position - 1
    game_board[index] = character
  end
end
