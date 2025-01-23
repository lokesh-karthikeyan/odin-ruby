# frozen_string_literal: true

require_relative '../movements/routes'
require_relative '../movements/movable'
require_relative '../movements/movement_factory'
require_relative '../checkable/checkable'

# Verifies whether the king can be protected if it's in "Check".
class DefendKing
  include Movable

  def defenders
    allies = ally_spots
    movable_pieces = allies.each_with_object([]) do |ally, moves|
      next if ally == spot

      piece_movements = compute_movements(board, ally, move_state)
      moves << ally if interpose_or_capture?(piece_movements) && safe_spot?(ally, piece_movements)
    end

    king_movements = compute_movements.any? ? spot : []
    movable_pieces += [king_movements]
    movable_pieces.keep_if(&:any?)
  end

  def trace_path(paths = {})
    enemy_spots.each do |enemy_spot|
      paths[enemy_spot] = []
      ROUTES.each do |route|
        paths[enemy_spot] = travel(route, spot)
        break if paths[enemy_spot].last == enemy_spot
      end
    end
    paths
  end

  private

  ROUTES = Routes::HORIZONTAL + Routes::VERTICAL + Routes::DIAGONAL + Routes::KNIGHT

  attr_accessor :board, :spot, :enemy_spots, :move_state

  def initialize(board, spot, enemy_spots, move_state)
    self.board = board
    self.spot = spot
    self.enemy_spots = enemy_spots
    self.move_state = move_state
  end

  def ally_spots(allies = [])
    board.each_with_index do |row, row_index|
      row.each_index do |column_index|
        location = [row_index, column_index]
        allies << location if ally?(location)
      end
    end

    allies
  end

  def compute_movements(board = self.board, spot = self.spot, move_state = self.move_state)
    MovementFactory.moves(board, spot, move_state)
  end

  def interpose_or_capture?(movements)
    paths = trace_path
    path_intersection = []
    paths.each_value { |path| path_intersection = movements & path }
    path_intersection.any?
  end

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
