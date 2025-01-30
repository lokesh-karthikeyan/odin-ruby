# frozen_string_literal: true

# Mixins: Common helper methods to find the valid moves of a chess piece.
module Movable
  def travel(route, spot, moves = [])
    loop do
      spot = compute_position(route, spot)
      moves << spot if range?(spot) && (null_piece?(spot) || enemy?(spot))

      break unless range?(spot) && null_piece?(spot)
    end
    moves
  end

  def find_allies(board, piece_color, allies = [])
    board.each_with_index do |row, row_index|
      row.each_index do |column_index|
        position = [row_index, column_index]

        allies << position if color(position) == piece_color
      end
    end

    allies
  end

  def find_king(piece_positions) = piece_positions.each { |position| return position if piece(position) == :King }

  def range?(position) = position.all?(0..7)

  def compute_position(route, spot) = route.zip(spot).map(&:sum)

  def piece(position) = board.dig(position.first, position.last).piece.type

  def color(position) = board.dig(position.first, position.last).piece.color

  def spot_label(position) = column_label[position.last] + row_label[position.first]

  def ally?(position)
    board.dig(spot.first, spot.last).piece.color == board.dig(position.first, position.last).piece.color
  end

  def enemy?(position)
    source_color = color(spot)
    target_color = color(position)

    source_color.eql?(:black) && target_color.eql?(:white) || source_color.eql?(:white) && target_color.eql?(:black)
  end

  def null_piece?(position) = board.dig(position.first, position.last).piece.type.to_s.strip.empty?

  def simulate_movements(board, source, target)
    duplicate_board = Marshal.load(Marshal.dump(board))
    move_piece!(duplicate_board, source[:spot], source[:piece_attributes])
    move_piece!(duplicate_board, target[:spot], target[:piece_attributes])
    duplicate_board
  end

  def move_piece!(duplicate_board, position, attributes)
    duplicate_board[position.first][position.last].piece.type = attributes.first
    duplicate_board[position.first][position.last].piece.color = attributes.last
  end

  def row_label = { 0 => '8', 1 => '7', 2 => '6', 3 => '5', 4 => '4', 5 => '3', 6 => '2', 7 => '1' }

  def column_label = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F', 6 => 'G', 7 => 'H' }

  def to_coordinates(spot_name)
    spot_name = spot_name.upcase
    column = column_label.key(spot_name[0])
    row = row_label.key(spot_name[1])
    [row, column]
  end
end
