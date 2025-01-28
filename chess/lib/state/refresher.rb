# frozen_string_literal: true

require_relative 'state'

# Refreshes the "Game State" and "Move State".
class Refresher
  def switch_active_color
    current_color = move_state.active_color
    next_color = current_color == :white ? :black : :white

    state_klass.update_move_state(:active_color, next_color)
  end

  def disable_white_side_castling
    state_klass.update_move_state(:white_king_side_castle?, false) if move_state.white_king_side_castle?
    state_klass.update_move_state(:white_queen_side_castle?, false) if move_state.white_queen_side_castle?
  end

  def disable_black_side_castling
    state_klass.update_move_state(:black_king_side_castle?, false) if move_state.black_king_side_castle?
    state_klass.update_move_state(:black_queen_side_castle?, false) if move_state.black_queen_side_castle?
  end

  def disable_white_king_side_castling
    state_klass.update_move_state(:white_king_side_castle?, false) if move_state.white_king_side_castle?
  end

  def disable_black_king_side_castling
    state_klass.update_move_state(:black_king_side_castle?, false) if move_state.black_king_side_castle?
  end

  def disable_white_queen_side_castling
    state_klass.update_move_state(:white_queen_side_castle?, false) if move_state.white_queen_side_castle?
  end

  def disable_black_queen_side_castling
    state_klass.update_move_state(:black_queen_side_castle?, false) if move_state.black_queen_side_castle?
  end

  def update_en_passant_target(spot) = state_klass.update_move_state(:en_passant_target, spot)

  def increment_half_move_clock
    current_count = move_state.half_move_clock
    state_klass.update_move_state(:half_move_clock, current_count + 1)
  end

  def reset_half_move_clock
    state_klass.update_move_state(:half_move_clock, 0)
  end

  def increment_full_move_number
    current_count = move_state.full_move_number
    state_klass.update_move_state(:full_move_number, current_count + 1)
  end

  def enable_check = state_klass.update_game_state(:check?, true)

  def disable_check = state_klass.update_game_state(:check?, false)

  def enable_check_mate = state_klass.update_game_state(:mate?, true)

  def enable_stale_mate = state_klass.update_game_state(:stale_mate?, true)

  private

  attr_accessor :move_state, :game_state, :state_klass

  def initialize(move_state, game_state, state_klass = State)
    self.move_state = move_state
    self.game_state = game_state
    self.state_klass = state_klass
  end
end
