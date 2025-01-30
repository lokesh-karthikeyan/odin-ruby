# frozen_string_literal: true

require_relative '../movements/movable'
require_relative './position_evaluation'
require_relative 'computation'

# Computes the next best move of the black piece.
class NextBestMove
  include Movable

  def determine_move(best_move = { source: [], target: [], score: 999_999 })
    source_spots = compute_klass.black_side_source_locations(board, move_state)
    movement_info = compute_klass.generate_moves(source_spots, board, move_state)
    look_ahead_black_moves(movement_info, best_move)
    [best_move[:source], best_move[:target]]
  end

  private

  attr_accessor :board, :move_state, :compute_klass

  def initialize(board, move_state, compute_klass = Computation)
    self.board = Marshal.load(Marshal.dump(board))
    self.move_state = Marshal.load(Marshal.dump(move_state))
    self.compute_klass = compute_klass
  end

  def look_ahead_black_moves(movement_info, best_move)
    movement_info.each do |source, targets|
      targets.each do |target|
        earlier_state = fetch_source_and_target_spot_info(source, target)
        make_move(source, target)
        weight = determine_white_moves
        undo_move(source, target, earlier_state)
        update_best_move(weight, best_move, source, target)
      end
    end
  end

  def determine_white_moves
    source_spots = compute_klass.white_side_source_locations(board, move_state)
    movement_info = compute_klass.generate_moves(source_spots, board, move_state)
    look_ahead_white_moves(movement_info)
  end

  def look_ahead_white_moves(movement_info, weight_list = [])
    movement_info.each do |source, targets|
      targets.each do |target|
        earlier_state = fetch_source_and_target_spot_info(source, target)
        make_move(source, target)
        weight = compute_weight(board, :white)
        undo_move(source, target, earlier_state)
        weight_list << weight
      end
    end
    weight_list
  end

  def update_best_move(weight_list, best_move, source, target)
    min_weight = weight_list.min
    return unless min_weight < best_move[:score]

    best_move[:source] = source
    best_move[:target] = target
    best_move[:score] = min_weight
  end

  def compute_weight(board, color) = PositionEvaluation.new(board).compute_weight(color)

  def fetch_source_and_target_spot_info(source, target)
    source_piece = piece(source)
    source_color = color(source)
    target_piece = piece(target)
    target_color = color(target)
    { source: [source_piece, source_color], target: [target_piece, target_color] }
  end

  def make_move(source, target)
    piece_type = piece(source)
    piece_color = color(source)

    assign_spot_details(source, '', '')
    assign_spot_details(target, piece_type, piece_color)
  end

  def undo_move(source, target, piece_data)
    source_piece_type, source_piece_color = piece_data[:source]
    target_piece_type, target_piece_color = piece_data[:target]

    assign_spot_details(source, source_piece_type, source_piece_color)
    assign_spot_details(target, target_piece_type, target_piece_color)
  end

  def assign_spot_details(source, piece_type, piece_color)
    row, column = source

    board[row][column].piece.type = piece_type
    board[row][column].piece.color = piece_color
  end
end
