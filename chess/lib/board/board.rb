# frozen_string_literal: true

require_relative 'box_factory/box_factory'
require_relative '../movements/movable'

# Board creation & modification.
class Board
  class << self
    include Movable

    attr_accessor :board_state

    def create(box = 8)
      board = Array.new(box) { Array.new(box) }
      assign_boxes(board, box)
      self.board_state = board
      board_state
    end

    def place_pieces(piece_locations, board = board_state)
      piece_locations.length.times do |row_index|
        piece_locations.length.times do |column_index|
          indices = [row_index, column_index]
          assign_pieces(piece_locations, indices)
        end
      end
      board
    end

    def update_pieces(source_spot, target_spot)
      piece_attributes = fetch_piece_attributes(source_spot)
      assign_piece_attributes(source_spot)
      assign_piece_attributes(target_spot, piece_attributes)
    end

    private

    def fen_key
      {
        r: [:Rook, [:black, ' ♜ ']], n: [:Knight, [:black, ' ♞ ']], b: [:Bishop, [:black, ' ♝ ']],
        q: [:Queen, [:black, ' ♛ ']], k: [:King, [:black, ' ♚ ']],
        R: [:Rook, [:white, ' ♜ ']], N: [:Knight, [:white, ' ♞ ']], B: [:Bishop, [:white, ' ♝ ']],
        Q: [:Queen, [:white, ' ♛ ']], K: [:King, [:white, ' ♚ ']],
        p: [:Pawn, [:black, ' ♟ ']], P: [:Pawn, [:white, ' ♟ ']],
        ' ': ['', ['', '']]
      }
    end

    def assign_boxes(board, box)
      box.times do |row_index|
        box.times do |column_index|
          board[row_index][column_index] = BoxFactory.create_boxes
          location = [row_index, column_index]
          board[row_index][column_index].label = spot_label(location)
        end
      end
    end

    def assign_pieces(piece_locations, indices)
      key = piece_locations.dig(indices.first, indices.last).to_sym
      piece_attributes = fen_key[key].flatten
      assign_piece_attributes(indices, piece_attributes)
    end

    def fetch_piece_attributes(indices, piece_attributes = [])
      row, column = indices
      piece_attributes << board_state.dig(row, column).piece.type
      piece_attributes << board_state.dig(row, column).piece.color
      piece_attributes << board_state.dig(row, column).piece.icon
      piece_attributes
    end

    def assign_piece_attributes(indices, piece_attributes = ['', '', ''])
      row, column = indices
      piece_type, piece_color, piece_icon = piece_attributes
      board_state[row][column].piece.type = piece_type
      board_state[row][column].piece.color = piece_color
      board_state[row][column].piece.icon = piece_icon
    end
  end
end
