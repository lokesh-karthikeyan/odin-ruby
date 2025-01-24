# frozen_string_literal: true

require_relative '../routes'
require_relative '../movable'
require_relative '../../checkable/checkable'

# Computes the King's possible legal moves.
class KingMoves
  include Movable

  def legal_moves(moves = [])
    ROUTES.each do |route|
      location = compute_position(route, spot)
      moves << location if range?(location) && (null_piece?(location) || enemy?(location))
    end
    moves.keep_if { |move| safe_position?(move) }
    moves.concat(castling_moves)
    moves
  end

  private

  ROUTES = Routes::HORIZONTAL + Routes::VERTICAL + Routes::DIAGONAL

  attr_accessor :board, :spot, :move_state

  def initialize(board, spot, move_state)
    self.board = board
    self.spot = spot
    self.move_state = move_state
  end

  def safe_position?(location)
    piece_type = piece(spot)
    piece_color = color(spot)

    source = { spot: spot, piece_attributes: ['', ''] }
    target = { spot: location, piece_attributes: [piece_type, piece_color] }
    duplicate_board = simulate_movements(board, source, target)

    king_safe?(duplicate_board, location)
  end

  def king_safe?(board, location) = Checkable.enemy_whereabouts(board, location).empty?

  def castling_moves(moves = [])
    piece_color = color(spot)

    moves << castle_move_spot(king_side: true) if king_side_castling?(piece_color)
    moves << castle_move_spot(queen_side: true) if queen_side_castling?(piece_color)
    moves
  end

  def king_side_castling?(piece_color)
    castling_side = "#{piece_color}_king".to_sym

    castling?(castling_side) && king_safe?(board, spot) &&
      king_side_pieces_in_place?(piece_color) && castling_spots_safe?(castling_side)
  end

  def queen_side_castling?(piece_color)
    castling_side = "#{piece_color}_queen".to_sym

    castling?(castling_side) && king_safe?(board, spot) &&
      queen_side_pieces_in_place?(piece_color) && castling_spots_safe?(castling_side)
  end

  def castling?(castling_side)
    method_name = "#{castling_side}_side_castle?"

    move_state.send(method_name)
  end

  def king_side_pieces_in_place?(piece_color)
    expectations = [[:King, piece_color], ['', ''], ['', ''], [:Rook, piece_color]]
    king_side_castle_spots = piece_color == :white ? king_row(white: true).last(4) : king_row(black: true).last(4)
    king_side_castle_spots = king_side_castle_spots.each { |piece_attr| piece_attr.each(&:strip) if is_a?(String) }
    expectations == king_side_castle_spots
  end

  def queen_side_pieces_in_place?(piece_color)
    expectations = [[:Rook, piece_color], ['', ''], ['', ''], ['', ''], [:King, piece_color]]
    queen_side_castle_spots = piece_color == :white ? king_row(white: true).first(5) : king_row(black: true).first(5)
    queen_side_castle_spots = queen_side_castle_spots.each { |piece_attr| piece_attr.each(&:strip) if is_a?(String) }
    expectations == queen_side_castle_spots
  end

  def king_row(black: false, white: false)
    return board.first.map { |spot| [spot.piece.type, spot.piece.color] } if black

    board.last.map { |spot| [spot.piece.type, spot.piece.color] } if white
  end

  def castling_spots_safe?(piece_type) = castling_spots[piece_type].all? { |location| safe_position?(location) }

  def castle_move_spot(king_side: false, queen_side: false)
    route = Routes::KING_SIDE_CASTLE if king_side
    route = Routes::QUEEN_SIDE_CASTLE if queen_side

    compute_position(route, spot)
  end

  def castling_spots
    {
      black_king: [[0, 5], [0, 6]], black_queen: [[0, 2], [0, 3]],
      white_king: [[7, 5], [7, 6]], white_queen: [[7, 2], [7, 3]]
    }
  end
end
