# frozen_string_literal: true

require_relative '../../movements/movable'

# Helper Class --> To check & modify the "Move & Game state".
class UpdateState
  class << self
    attr_accessor :board_state

    include Movable

    def active_color(refresher) = refresher.switch_active_color

    def castling(inspector, refresher, source, target, active_player)
      color = active_player.color
      white_side_castling(inspector, refresher, source, target) if color.eql?(:white)
      black_side_castling(inspector, refresher, source, target) if color.eql?(:black)
      verify_black_rooks_in_place(inspector, refresher)
      verify_white_rooks_in_place(inspector, refresher)
    end

    def en_passant_target(inspector, refresher, source, target)
      target_label = fetch_en_passant_target(inspector, source, target)
      refresher.update_en_passant_target(target_label)
    end

    def half_move_clock(inspector, refresher, prior_pieces)
      source, target = prior_pieces
      result_bool = inspector.increment_half_move_count?(source, target)

      result_bool ? refresher.increment_half_move_clock : refresher.reset_half_move_clock
    end

    def full_move_number(refresher, active_player)
      color = active_player.color

      refresher.increment_full_move_number if color.eql?(:white)
    end

    def check(inspector, refresher, board_state, active_player)
      self.board_state = board_state
      allies = find_allies(board_state, active_player.color)
      king_unsafe = inspector.check?(allies)

      refresher.enable_check if king_unsafe
      refresher.disable_check unless king_unsafe
    end

    def mate(inspector, refresher, game_state, movable_pieces)
      refresher.enable_check_mate if inspector.mate?(game_state, movable_pieces)
    end

    def stale_mate(inspector, refresher, game_state, movable_pieces)
      refresher.enable_stale_mate if inspector.stale_mate?(game_state, movable_pieces)
    end

    private

    def white_side_castling(inspector, refresher, source, target)
      refresher.disable_white_side_castling if inspector.white_king_moved?(source, target)
      refresher.disable_white_king_side_castling if inspector.right_white_rook_moved?(source, target)
      refresher.disable_white_queen_side_castling if inspector.left_white_rook_moved?(source, target)
    end

    def black_side_castling(inspector, refresher, source, target)
      refresher.disable_black_side_castling if inspector.black_king_moved?(source, target)
      refresher.disable_black_king_side_castling if inspector.right_black_rook_moved?(source, target)
      refresher.disable_black_queen_side_castling if inspector.left_black_rook_moved?(source, target)
    end

    def verify_black_rooks_in_place(inspector, refresher)
      refresher.disable_black_queen_side_castling unless inspector.left_black_rook_present?
      refresher.disable_black_king_side_castling unless inspector.right_black_rook_present?
    end

    def verify_white_rooks_in_place(inspector, refresher)
      refresher.disable_white_queen_side_castling unless inspector.left_white_rook_present?
      refresher.disable_white_king_side_castling unless inspector.right_white_rook_present?
    end

    def fetch_en_passant_target(inspector, source, target)
      return '-' unless inspector.en_passant?(source, target)

      spot_label(target).downcase
    end

    def color(position) = board_state.dig(position.first, position.last).piece.color
  end
end
