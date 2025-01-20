# frozen_string_literal: true

require_relative '../movements/routes'
require_relative '../movements/movable'
require_relative './inspect_enemy_piece'

# Inspect King's safety if it's in a position of Check (or) Mate.
module Checkable
  # Inspect King's safety in a horizontal path
  class HorizontalCheckable
    include Movable
    include InspectEnemyPiece

    def enemy_whereabouts(locations = [])
      ROUTES.each { |route| locations.append(*explore_path(route)) }
      locations.keep_if { |location| rook?(location) || queen?(location) || king_nearby?(location) }
      locations
    end

    private

    ROUTES = Routes::HORIZONTAL

    attr_accessor :board, :spot

    def initialize(board, spot)
      self.board = board
      self.spot = spot
    end
  end
end
