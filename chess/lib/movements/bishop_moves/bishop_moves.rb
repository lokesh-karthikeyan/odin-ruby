# frozen_string_literal: true

require_relative 'routes'
require_relative 'movable'

# Computes the Bishop's possible legal moves.
class BishopMoves
  include Movable

  def legal_moves(moves = [])
    ROUTES.each { |route| moves.append(*travel(route, spot)) }
    moves
  end

  private

  ROUTES = Routes::DIAGONAL

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end
end
