# frozen_string_literal: true

require_relative '../movements/movable'

# Inspects if any "Pawn" is allowed for promotion.
class PawnPromotionInspector
  include Movable

  def pawn_promotion?(target, color)
    piece_type = piece(target)
    row, = target

    color.eql?(:black) && piece_type.eql?(:Pawn) && row.eql?(7) ||
      color.eql?(:white) && piece_type.eql?(:Pawn) && row.eql?(0)
  end

  private

  attr_accessor :board

  def initialize(board) = self.board = board
end
