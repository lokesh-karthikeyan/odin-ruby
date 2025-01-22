# frozen_string_literal: true

# Mixins: Common helper methods to find the valid moves of a chess piece.
module Movable
  def travel(route, spot, moves = [])
    loop do
      spot = compute_position(route, spot)
      moves << spot if range?(spot) && (null_piece?(spot) || enemy?(spot))

      break unless range?(spot) && null_piece?(spot)
    end
    moves
  end

  def range?(position) = position.all?(0..7)

  def compute_position(route, spot) = route.zip(spot).map(&:sum)

  def piece(position) = board.dig(position.first, position.last).piece.type

  def ally?(position)
    board.dig(spot.first, spot.last).piece.color == board.dig(position.first, position.last).piece.color
  end

  def color(position) = board.dig(position.first, position.last).piece.color

  def enemy?(position)
    source_color = color(spot)
    target_color = color(position)

    source_color.eql?(:black) && target_color.eql?(:white) || source_color.eql?(:white) && target_color.eql?(:black)
  end

  def null_piece?(position) = board.dig(position.first, position.last).piece.type.to_s.strip.empty?
end
