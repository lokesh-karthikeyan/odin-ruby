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
    piece_color = color(spot).to_s
    king_side_method = "#{piece_color}_king_side_castling?"
    queen_side_method = "#{piece_color}_queen_side_castling?"

    moves << king_side_castle_move if send(king_side_method)
    moves << queen_side_castle_move if send(queen_side_method)
    moves
  end

  def black_king_side_castling?
    move_state.black_king_side_castle? && king_safe?(board, spot) &&
      castling_spots_empty?(:black_king) && castling_spots_safe?(:black_king)
  end

  def black_queen_side_castling?
    move_state.black_queen_side_castle? && king_safe?(board, spot) &&
      castling_spots_empty?(:black_queen) && castling_spots_safe?(:black_queen)
  end

  def white_king_side_castling?
    move_state.white_king_side_castle? && king_safe?(board, spot) &&
      castling_spots_empty?(:white_king) && castling_spots_safe?(:white_king)
  end

  def white_queen_side_castling?
    move_state.white_queen_side_castle? && king_safe?(board, spot) &&
      castling_spots_empty?(:white_queen) && castling_spots_safe?(:white_queen)
  end

  def castling_spots_empty?(piece_type) = castling_spots[piece_type].all? { |location| null_piece?(location) }

  def castling_spots_safe?(piece_type) = castling_spots[piece_type].last(2).all? { |location| safe_position?(location) }

  def king_side_castle_move
    route = Routes::KING_SIDE_CASTLE
    compute_position(route, spot)
  end

  def queen_side_castle_move
    route = Routes::QUEEN_SIDE_CASTLE
    compute_position(route, spot)
  end

  def castling_spots
    {
      black_king: [[0, 5], [0, 6]],
      black_queen: [[0, 1], [0, 2], [0, 3]],
      white_king: [[7, 5], [7, 6]],
      white_queen: [[7, 1], [7, 2], [7, 3]]
    }
  end
end
