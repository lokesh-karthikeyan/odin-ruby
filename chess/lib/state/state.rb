# frozen_string_literal: true

require_relative 'game_state/game_state'
require_relative 'move_state/move_state'

# Creates & updates the "Game State" & "Move State" instances.
class State
  class << self
    attr_accessor :game_state, :move_state

    def create_game_state(check: false, mate: false, stale_mate: false)
      self.game_state = GameState.new(check, mate, stale_mate)
      game_state
    end

    def update_game_state(member, value) = (game_state[member] = value)

    def create_move_state(arguments)
      active_color, white_king_castle, white_queen_castle, black_king_castle,
        black_queen_castle, en_passant, half_move, full_move = arguments
      self.move_state = MoveState.new(active_color, white_king_castle, white_queen_castle, black_king_castle,
                                      black_queen_castle, en_passant, half_move, full_move)
      move_state
    end

    def update_move_state(member, value) = (move_state[member] = value)
  end
end
