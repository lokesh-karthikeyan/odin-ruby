# frozen_string_literal: true

require_relative '../movements/movements'
require_relative '../movements/movement_factory'

# Handles computation for next possible move.
class Computation
  class << self
    def black_side_source_locations(board, move_state)
      move_state.active_color = :black
      movable_spots = Movements.new(board, move_state)
      movable_spots.legal_moves
    end

    def white_side_source_locations(board, move_state)
      move_state.active_color = :white
      movable_spots = Movements.new(board, move_state)
      movable_spots.legal_moves
    end

    def generate_moves(source_locations, board, move_state)
      movement_info = {}
      source_locations.each { |location| movement_info[location] = compute_movements(board, location, move_state) }
      sort_moves(movement_info)
    end

    private

    def compute_movements(board, location, move_state) = MovementFactory.moves(board, location, move_state)

    def sort_moves(movement_info) = movement_info.each { |key, value| movement_info[key] = value.sort }
  end
end
