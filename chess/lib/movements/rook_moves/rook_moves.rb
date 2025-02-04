# frozen_string_literal: true

require_relative '../routes'
require_relative '../movable'

# Computes the Rook's possible legal moves.
class RookMoves
  include Movable

  def legal_moves(moves = [])
    ROUTES.each { |route| moves.append(*travel(route, spot)) }
    moves
  end

  private

  ROUTES = Routes::HORIZONTAL + Routes::VERTICAL

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end
end
