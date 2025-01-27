# frozen_string_literal: true

# Inspects if the "Half-Move clock" can be incremented.
class HalfMoveClockInspector
  def increment_count?(source, target) = source_piece_validator(source) && target_piece_validator(target)

  private

  def source_piece_validator(source)
    piece, = source
    piece != :Pawn
  end

  def target_piece_validator(target) = target.all? { |attributes| attributes.to_s.strip.empty? }
end
