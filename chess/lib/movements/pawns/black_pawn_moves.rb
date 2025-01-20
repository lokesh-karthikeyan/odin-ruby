# frozen_string_literal: true

require_relative '../routes'
require_relative '../movable'

# Computes the Black Pawn's possible legal moves.
class BlackPawnMoves
  include Movable

  def legal_moves(moves = [])
    first_forward_step = move_forward
    second_forward_step = advance_two_steps?(first_forward_step) ? move_forward(double: true) : []
    diagonal_capture_moves = capture_moves
    moves << first_forward_step << second_forward_step << diagonal_capture_moves
    moves.keep_if(&:any?)
    moves
  end

  private

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end

  def advance_two_steps?(first_step) = first_step.any? && spot.first.eql?(1)

  def move_forward(moves = [], double: false)
    one_step = Routes::BLACK_PAWN_SINGLE_ADVANCE
    two_step = Routes::BLACK_PAWN_DOUBLE_ADVANCE

    location = double ? compute_position(two_step, spot) : compute_position(one_step, spot)
    return moves unless range?(location) && null_piece?(location)

    moves << location if null_piece?(location)
    moves.length.eql?(1) ? moves.flatten : moves
  end

  def capture_moves(moves = [])
    left_diagonal_location = compute_position(Routes::BLACK_PAWN_LEFT_CAPTURE, spot)
    right_diagonal_location = compute_position(Routes::BLACK_PAWN_RIGHT_CAPTURE, spot)

    moves << left_diagonal_location if capture_move?(left_diagonal_location) || left_side_en_passant?
    moves << right_diagonal_location if capture_move?(right_diagonal_location) || right_side_en_passant?
    moves.length.eql?(1) ? moves.flatten : moves
  end

  def capture_move?(location) = range?(location) && enemy?(location)

  def left_side_en_passant?
    location = compute_position(Routes::LEFT_SIDE_EN_PASSANT, spot)
    range?(location) && en_passant?(location)
  end

  def right_side_en_passant?
    location = compute_position(Routes::RIGHT_SIDE_EN_PASSANT, spot)
    range?(location) && en_passant?(location)
  end

  def en_passant?(location) = move_state.en_passant_target == fetch_spot_label(location) && enemy_pawn?(location)

  def fetch_spot_label(location) = board.dig(location.first, location.last).label.downcase

  def enemy_pawn?(location) = enemy?(location) && board.dig(location.first, location.last).piece.type == :Pawn
end
