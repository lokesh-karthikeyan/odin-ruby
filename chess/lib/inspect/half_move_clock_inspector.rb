# frozen_string_literal: true

require_relative '../movements/movable'

# Inspects if the "Half-Move clock" can be incremented.
class HalfMoveClockInspector
  include Movable

  def increment_count?(source_piece, target_piece)
    source_piece_validator(source_piece) && target_piece_validator(target_piece)
  end

  private

  def source_piece_validator(piece) = piece != :Pawn

  def target_piece_validator(piece) = piece.to_s.strip.empty?
end
