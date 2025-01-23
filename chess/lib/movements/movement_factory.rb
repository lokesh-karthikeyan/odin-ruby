# frozen_string_literal: true

require_relative 'rook_moves'
require_relative 'knight_moves'
require_relative 'bishop_moves'
require_relative 'queen_moves'
require_relative 'king_moves'
require_relative 'pawn_moves'
require_relative 'movable'

# Factory class for creating instances of the piece's moves.
class MovementFactory
  class << self
    include Movable

    attr_accessor :board, :spot, :move_state

    def moves(board, spot, move_state)
      self.board = board
      self.spot = spot
      self.move_state = move_state
      piece_type = piece(spot).to_s.downcase
      method_name = "#{piece_type}_movements"
      send(method_name)
    end

    private

    def rook_movements = RookMoves.new(board, spot, move_state).legal_moves

    def knight_movements = KnightMoves.new(board, spot, move_state).legal_moves

    def bishop_movements = BishopMoves.new(board, spot, move_state).legal_moves

    def queen_movements = QueenMoves.new(board, spot, move_state).legal_moves

    def king_movements = KingMoves.new(board, spot, move_state).legal_moves

    def pawn_movements = PawnMoves.new(board, spot, move_state).legal_moves
  end
end
