# frozen_string_literal: true

require_relative '../movements/routes'
require_relative '../movements/movable'
require_relative './inspect_enemy_piece'

# Inspect King's safety if it's in a position of Check (or) Mate.
module Checkable
  # Inspect King's safety in a diagonal path
  class DiagonalCheckable
    include Movable
    include InspectEnemyPiece

    def enemy_whereabouts(locations = [])
      ROUTES.each { |route| locations.append(*explore_path(route)) }
      locations.keep_if do |location|
        bishop?(location) || queen?(location) || king_nearby?(location) || pawn_nearby?(location)
      end
      locations
    end

    private

    ROUTES = Routes::DIAGONAL

    attr_accessor :board, :spot

    def initialize(board, spot)
      self.board = board
      self.spot = spot
    end
  end
end
