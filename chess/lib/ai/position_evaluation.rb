# frozen_string_literal: true

# Evaluates the board & computes the weight of current state.
class PositionEvaluation
  def compute_weight(color, score = 0)
    board.flatten.each do |spot|
      piece = spot.piece.type
      next if piece.to_s.strip.empty?

      piece_color = spot.piece.color
      color_checker_value = color.eql?(piece_color) ? 1 : -1
      score += (piece_weights[piece] * color_checker_value)
    end
    score
  end

  def piece_weights = { Pawn: 10, Knight: 30, Bishop: 30, Rook: 50, Queen: 90, King: 900, '': 0 }

  private

  attr_accessor :board

  def initialize(board) = self.board = board
end
