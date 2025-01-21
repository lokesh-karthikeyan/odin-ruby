# frozen_string_literal: true

require_relative '../movements/routes'
require_relative '../movements/movable'
require_relative './inspect_enemy_piece'

# Inspect King's safety if it's in a position of Check (or) Mate.
module Checkable
  # Inspect King's safety in the knight's path
  class KnightCheckable
    include Movable
    include InspectEnemyPiece

    def enemy_whereabouts(locations = [])
      ROUTES.each do |route|
        position = compute_position(route, spot)
        locations << position if range?(position) && enemy?(position) && knight?(position)
      end
      locations
    end

    private

    ROUTES = Routes::KNIGHT

    attr_accessor :board, :spot

    def initialize(board, spot)
      self.board = board
      self.spot = spot
    end
  end
end
