# frozen_string_literal: true

require_relative '../movable'
require_relative 'black_pawn_moves'
require_relative 'white_pawn_moves'

# Abstract class to compute Pawn's possible legal moves.
class PawnMoves
  include Movable

  def legal_moves
    piece_color = color(spot)

    return BlackPawnMoves.new(board, spot, move_state).legal_moves if piece_color == :black

    WhitePawnMoves.new(board, spot, move_state).legal_moves if piece_color == :white
  end

  private

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end
end
