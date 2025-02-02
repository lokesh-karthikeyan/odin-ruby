# frozen_string_literal: true

require_relative '../../movements/movements'
require_relative '../../movements/movement_factory'
require_relative '../../player/player_choice'
require_relative '../../ai/ai_choice'
require_relative '../../movements/movable'

# Helper Class --> To ask / fetch source piece spot.
class EnquireSource
  class << self
    attr_accessor :board_state

    include Movable

    def feedback(active_player, inactive_player, move_state, board_state)
      player_type = active_player.type
      return computer_choice(active_player, move_state, board_state) if player_type == :Computer

      player_choice(active_player, inactive_player, move_state, board_state) if player_type == :Human
    end

    private

    def player_choice(active_player, inactive_player, move_state, board_state)
      self.board_state = board_state
      exit_options = %w[q s]

      active_spots = find_active_spots(board_state, active_player.color, inactive_player.color)
      movable_pieces = find_movable_pieces(move_state)
      source = find_player_choice(active_spots, movable_pieces, active_player.name)

      exit_options.include?(source) ? source : to_coordinates(source)
    end

    def computer_choice(active_player, move_state, board_state)
      source = find_ai_choice(board_state, move_state, active_player.name)
      sleep(1)
      to_coordinates(source)
    end

    def find_active_spots(board_state, active_color, inactive_color)
      allies = find_allies(board_state, active_color)
      enemies = find_allies(board_state, inactive_color)
      allies = to_labels(allies)
      enemies = to_labels(enemies)

      [allies, enemies]
    end

    def find_movable_pieces(move_state)
      movable_pieces = Movements.new(board_state, move_state).legal_moves
      to_labels(movable_pieces)
    end

    def find_player_choice(active_spots, movable_labels, name)
      PlayerChoice.source_piece(active_spots, movable_labels, name)
    end

    def find_ai_choice(board_state, move_state, name) = AIChoice.source_piece(board_state, move_state, name)

    def to_labels(positions) = positions.map { |position| spot_label(position).downcase }

    def color(position) = board_state.dig(position.first, position.last).piece.color
  end
end
