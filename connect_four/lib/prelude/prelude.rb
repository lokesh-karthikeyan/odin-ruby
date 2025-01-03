# frozen_string_literal: true

require_relative '../displayable/displayable'

# Prelude to the 'Connect Four' game.
class Prelude
  private

  ROWS = 6
  COLUMNS = 7

  include Displayable

  def initialize
    print_game_title
    print_game_information
    board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    color_id = { 1 => 'yellow', 2 => 'red' }
    print_board(board, color_id)
    print_game_rules
  end
end
