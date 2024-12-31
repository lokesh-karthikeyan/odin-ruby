# frozen_string_literal: true

# Components and Functionalities related to the 'Game Board'.
class GameBoard
  ROWS = 6
  COLUMNS = 7

  attr_accessor :board, :last_move

  def initialize
    self.board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
  end

  def update_board(position, player_id)
    index = position - 1
    current_row = ROWS - 1
    current_row -= 1 while board[current_row][index] != 0
    board[current_row][index] = player_id
    self.last_move = [current_row, index]
  end
end
