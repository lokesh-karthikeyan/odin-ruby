# frozen_string_literal: true

require_relative 'routes'
require_relative 'movable'

# Computes the Knight's possible legal moves.
class KnightMoves
  include Movable

  def legal_moves(moves = [])
    ROUTES.each do |route|
      location = compute_position(route, spot)
      moves << location if range?(location) && (null_piece?(location) || enemy?(location))
    end
    moves
  end

  private

  ROUTES = Routes::KNIGHT

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end
end
