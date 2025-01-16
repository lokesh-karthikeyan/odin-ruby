# frozen_string_literal: true

require_relative 'box_factory/box_factory'

# Creates a board object with full of boxes & pieces.
class Board
  class << self
    def create(box = 8)
      board = Array.new(box) { Array.new(box) }
      assign_boxes(board, box)
      board
    end

    def place_pieces(piece_locations, board)
      piece_locations.length.times do |row_index|
        piece_locations.length.times do |column_index|
          indices = [row_index, column_index]
          assign_pieces(piece_locations, board, indices)
        end
      end
      board
    end

    private

    def fen_key
      {
        r: [:Rook, [:black, ' ♜ ']], n: [:Knight, [:black, ' ♞ ']], b: [:Bishop, [:black, ' ♝ ']],
        q: [:Queen, [:black, ' ♛ ']], k: [:King, [:black, ' ♚ ']],
        R: [:Rook, [:white, ' ♜ ']], N: [:Knight, [:white, ' ♞ ']], B: [:Bishop, [:white, ' ♝ ']],
        Q: [:Queen, [:white, ' ♛ ']], K: [:King, [:white, ' ♚ ']],
        p: [:Pawn, [:black, '♟ ']], P: [:Pawn, [:white, '♟ ']],
        ' ': ['', ['', '']]
      }
    end

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

    def assign_pieces(piece_locations, board, indices)
      key = piece_locations.dig(indices.first, indices.last).to_sym
      assign_piece_type(board, indices, key)
      assign_piece_color(board, indices, key)
      assign_piece_icon(board, indices, key)
    end

    def assign_piece_type(board, indices, key) = board[indices.first][indices.last].piece.type = fen_key[key].first

    def assign_piece_color(board, indices, key)
      board[indices.first][indices.last].piece.color = fen_key[key].last.first
    end

    def assign_piece_icon(board, indices, key) = board[indices.first][indices.last].piece.icon = fen_key[key].last.last
  end
end
