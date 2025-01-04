# frozen_string_literal: true

require_relative '../displayable/displayable'

# Components and Functionalities related to the 'Game Board'.
class GameBoard
  include Displayable

  def initialize(winning_condition_checks)
    self.board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    self.winning_condition_checks = winning_condition_checks
  end

  def update_board(position, player_id)
    index = compute_index(position)
    current_row = compute_index(ROWS)
    current_row -= 1 while board[current_row][index] != 0
    board[current_row][index] = player_id
    self.last_move = [current_row, index]
  end

  def valid_position?(position)
    index = compute_index(position)
    return false if board.first[index].nil?

    board.first[index].zero?
  end

  def tie? = board.flatten.none?(&:zero?)

  def won?(player_id) = winning_condition_checks.conditions_satisfied?(board, last_move, player_id)

  def display_board(player_disc_id) = print_board(board, player_disc_id)

  private

  ROWS = 6
  COLUMNS = 7

  attr_accessor :board, :last_move, :winning_condition_checks

  def compute_index(position) = (position - 1)
end
