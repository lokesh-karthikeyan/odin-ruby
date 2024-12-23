# frozen_string_literal: true

# This Class computes the possible moves from the given coordinates.
class PossibleMoves
  POSSIBILITIES = [[2, 1], [1, 2], [-2, 1], [-1, 2], [2, -1], [1, -2], [-2, -1], [-1, -2]].freeze

  def valid_moves(coordinates)
    POSSIBILITIES.each_with_object([]) do |move, valid_moves|
      coordinate_x = move.first + coordinates.first
      coordinate_y = move.last + coordinates.last

      valid_moves << [coordinate_x, coordinate_y] if in_range?(coordinate_x) && in_range?(coordinate_y)
    end
  end

  private

  def in_range?(number) = number.between?(0, 7)
end
