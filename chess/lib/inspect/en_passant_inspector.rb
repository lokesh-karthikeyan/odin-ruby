# frozen_string_literal: true

require_relative '../movements/movable'

# Inspects to determine if the move can allow "En Passant".
class EnPassantInspector
  include Movable

  def en_passant?(source, target)
    piece_type = piece(target)
    return false if piece_type != :Pawn

    source_row, = source
    target_row, = target
    piece_color = color(target)

    black_piece_en_passant?(source_row, target_row, piece_color) ||
      white_piece_en_passant?(source_row, target_row, piece_color)
  end

  def right_black_pawn?(source, target)
    row, column = source
    adjacent_spot = [row, column + 1]
    possible_target = [row - 1, column + 1]

    range?(adjacent_spot) && piece(adjacent_spot) == :Pawn &&
      color(adjacent_spot) == :black && possible_target.eql?(target)
  end

  def left_black_pawn?(source, target)
    row, column = source
    adjacent_spot = [row, column - 1]
    possible_target = [row - 1, column - 1]

    range?(adjacent_spot) && piece(adjacent_spot) == :Pawn &&
      color(adjacent_spot) == :black && possible_target.eql?(target)
  end

  def right_white_pawn?(source, target)
    row, column = source
    adjacent_spot = [row, column + 1]
    possible_target = [row + 1, column + 1]

    range?(adjacent_spot) && piece(adjacent_spot) == :Pawn &&
      color(adjacent_spot) == :white && possible_target.eql?(target)
  end

  def left_white_pawn?(source, target)
    row, column = source
    adjacent_spot = [row, column - 1]
    possible_target = [row + 1, column - 1]

    range?(adjacent_spot) && piece(adjacent_spot) == :Pawn &&
      color(adjacent_spot) == :white && possible_target.eql?(target)
  end

  private

  attr_accessor :board

  def initialize(board) = self.board = board

  def black_piece_en_passant?(source, target, color) = source.eql?(1) && target.eql?(3) && color.eql?(:black)

  def white_piece_en_passant?(source, target, color) = source.eql?(6) && target.eql?(4) && color.eql?(:white)
end
