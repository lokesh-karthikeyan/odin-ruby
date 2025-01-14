# frozen_string_literal: true

require_relative '../box_factory/box_factory'

# Creates a board object with full of boxes & pieces.
class Board
  class << self
    def create(box = 8)
      board = Array.new(box) { Array.new(box) }
      assign_boxes(board, box)
      board
    end

    private

    def assign_boxes(board, box)
      box.times do |row_index|
        box.times do |column_index|
          board[row_index][column_index] = BoxFactory.create_boxes
          board[row_index][column_index].label = assign_labels(row_index, column_index)
        end
      end
    end

    def assign_labels(row_index, column_index)
      row_label = { 0 => '8', 1 => '7', 2 => '6', 3 => '5', 4 => '4', 5 => '3', 6 => '2', 7 => '1' }
      column_label = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F', 6 => 'G', 7 => 'H' }
      column_label[column_index] + row_label[row_index]
    end
  end
end
