# frozen_string_literal: true

require_relative '../movements/movable'

# Inspects castling related movements/placements.
class CastlingInspector
  include Movable

  def castling?(source, target)
    piece_type = piece(target)
    piece_color = color(target)
    piece_attributes = [piece_type, piece_color]

    black_side_castling?(source, target, piece_attributes) || white_side_castling?(source, target, piece_attributes)
  end

  def black_king_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [0, 4] && piece_type.eql?(:King) && piece_color.eql?(:black)
  end

  def white_king_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [7, 4] && piece_type.eql?(:King) && piece_color.eql?(:white)
  end

  def left_black_rook_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [0, 0] && piece_type.eql?(:Rook) && piece_color.eql?(:black)
  end

  def right_black_rook_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [0, 7] && piece_type.eql?(:Rook) && piece_color.eql?(:black)
  end

  def left_white_rook_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [7, 0] && piece_type.eql?(:Rook) && piece_color.eql?(:white)
  end

  def right_white_rook_moved?(source, target)
    piece_type = piece(target)
    piece_color = color(target)

    source == [7, 7] && piece_type.eql?(:Rook) && piece_color.eql?(:white)
  end

  private

  attr_accessor :board

  def initialize(board) = self.board = board

  def black_side_castling?(source, target, piece_attributes)
    castling_spots = [[0, 2], [0, 6]]
    piece_type, piece_color = piece_attributes

    source == [0, 4] && castling_spots.include?(target) && piece_type.eql?(:King) && piece_color.eql?(:black)
  end

  def white_side_castling?(source, target, piece_attributes)
    castling_spots = [[7, 2], [7, 6]]
    piece_type, piece_color = piece_attributes

    source == [7, 4] && castling_spots.include?(target) && piece_type.eql?(:King) && piece_color.eql?(:white)
  end
end
