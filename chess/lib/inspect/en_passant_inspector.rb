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

  private

  attr_accessor :board

  def initialize(board) = self.board = board

  def black_piece_en_passant?(source, target, color) = source.eql?(1) && target.eql?(3) && color.eql?(:black)

  def white_piece_en_passant?(source, target, color) = source.eql?(6) && target.eql?(4) && color.eql?(:white)
end
