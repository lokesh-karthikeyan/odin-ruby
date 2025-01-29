# frozen_string_literal: true

require_relative 'movable'
require_relative 'movement_factory'
require_relative '../checkable/checkable'

# Computes all moves that do not result in "Check".
class Movements
  include Movable

  def legal_moves
    ally_spots = find_allies(board, move_state.active_color)
    self.spot = find_king(ally_spots).flatten

    ally_spots.each_with_object([]) do |ally_spot, movable_pieces|
      piece_movements = compute_movements(board, ally_spot, move_state)
      next if piece_movements.empty?

      movable_pieces << ally_spot if safe_spot?(ally_spot, piece_movements)
    end
  end

  private

  attr_accessor :board, :move_state, :spot

  def initialize(board, move_state)
    self.board = board
    self.move_state = move_state
  end

  def compute_movements(board, spot, move_state) = MovementFactory.moves(board, spot, move_state)

  def safe_spot?(location, piece_movements)
    piece_type = piece(location)
    piece_color = color(location)

    source = { spot: location, piece_attributes: ['', ''] }

    piece_movements.each do |move|
      target = { spot: move, piece_attributes: [piece_type, piece_color] }
      duplicate_board = simulate_movements(board, source, target)

      return true if king_safe?(duplicate_board, spot)
    end

    false
  end

  def king_safe?(board, spot) = Checkable.enemy_whereabouts(board, spot).empty?
end
