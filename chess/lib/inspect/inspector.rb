# frozen_string_literal: true

require_relative 'castling_inspector'
require_relative 'game_over_inspector'
require_relative 'en_passant_inspector'
require_relative 'pawn_promotion_inspector'
require_relative 'half_move_clock_inspector'

# Abstract class for inspection on moves/winning scenarios.
class Inspector
  def check?(allies) = GameOverInspector.new(board, move_state).check?(allies)

  def mate?(game_state, movable_pieces) = GameOverInspector.new(board, move_state).mate?(game_state, movable_pieces)

  def stale_mate?(game_state, movable_pieces)
    GameOverInspector.new(board, move_state).stale_mate?(game_state, movable_pieces)
  end

  def three_fold_repetition?(logs) = GameOverInspector.new(board, move_state).three_fold_repetition?(logs)

  def fifty_move_rule? = GameOverInspector.new(board, move_state).fifty_move_rule?

  def castling?(source, target) = CastlingInspector.new(board).castling?(source, target)

  def black_king_moved?(source, target) = CastlingInspector.new(board).black_king_moved?(source, target)

  def white_king_moved?(source, target) = CastlingInspector.new(board).white_king_moved?(source, target)

  def left_black_rook_moved?(source, target) = CastlingInspector.new(board).left_black_rook_moved?(source, target)

  def right_black_rook_moved?(source, target) = CastlingInspector.new(board).right_black_rook_moved?(source, target)

  def left_white_rook_moved?(source, target) = CastlingInspector.new(board).left_white_rook_moved?(source, target)

  def right_white_rook_moved?(source, target) = CastlingInspector.new(board).right_white_rook_moved?(source, target)

  def left_black_rook_present? = CastlingInspector.new(board).left_black_rook_present?

  def right_black_rook_present? = CastlingInspector.new(board).right_black_rook_present?

  def left_white_rook_present? = CastlingInspector.new(board).left_white_rook_present?

  def right_white_rook_present? = CastlingInspector.new(board).right_white_rook_present?

  def en_passant?(source, target) = EnPassantInspector.new(board).en_passant?(source, target)

  def right_white_pawn?(source, target) = EnPassantInspector.new(board).right_white_pawn?(source, target)

  def right_black_pawn?(source, target) = EnPassantInspector.new(board).right_black_pawn?(source, target)

  def left_white_pawn?(source, target) = EnPassantInspector.new(board).left_white_pawn?(source, target)

  def left_black_pawn?(source, target) = EnPassantInspector.new(board).left_black_pawn?(source, target)

  def increment_half_move_count?(source, target) = HalfMoveClockInspector.new.increment_count?(source, target)

  def pawn_promotion?(target, color) = PawnPromotionInspector.new(board).pawn_promotion?(target, color)

  private

  attr_accessor :board, :move_state

  def initialize(board, move_state)
    self.board = board
    self.move_state = move_state
  end
end
