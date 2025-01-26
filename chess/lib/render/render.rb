# frozen_string_literal: true

require_relative '../movements/movable'
require_relative '../colorable/colorable'
require_relative 'renderable'

# Renders the given board
class Render
  include Movable
  include Renderable
  using Colorable

  def board_renderer(current_location = [], movable_spots = [], clear_screen: true)
    clear_terminal_screen if clear_screen
    self.printable_board = filter_icons
    highlight_current_spot(current_location)
    highlight_movable_spots(movable_spots)
    fill_spot_colors

    print_top_bottom_borders
    print_board
    print_top_bottom_borders
  end

  private

  attr_accessor :board, :odd_row, :even_row, :row_indicators, :column_indicators, :printable_board

  def initialize(board)
    self.board = board
    self.even_row = %i[hunter_green dark_green] * 4
    self.odd_row = %i[dark_green hunter_green] * 4
    self.row_indicators = ['  𝟠  ', '  𝟟  ', '  𝟞  ', '  𝟝  ', '  𝟜  ', '  𝟛  ', '  𝟚  ', '  𝟙  ']
    self.column_indicators = ['  𝔸  ', '  𝔹  ', '  ℂ  ', '  𝔻  ', '  𝔼  ', '  𝔽  ', '  𝔾  ', '  ℍ  ']
  end

  def clear_terminal_screen = system('clear')

  def filter_icons
    board.map do |row|
      row.map do |spot|
        piece_type = spot.piece.icon
        piece_type.strip.empty? ? '     ' : " #{piece_type} "
      end
    end
  end

  def highlight_current_spot(spot)
    return if spot.empty?

    piece_type = fetch_icon(spot)

    printable_board[spot.first][spot.last] = piece_type.color_bg(:blue)
  end

  def fetch_icon(spot) = printable_board.dig(spot.first, spot.last)

  def highlight_movable_spots(spots)
    spots.each do |spot|
      current_icon = fetch_icon(spot)
      icon_state = current_icon.strip.empty?
      printable_board[spot.first][spot.last] = icon_state ? '  ▪  '.color_fg(:blue) : current_icon.color_bg(:light_red)
    end
  end

  def fill_spot_colors
    printable_board.each_with_index do |row, row_index|
      row.each_with_index do |piece_type, column_index|
        spot = [row_index, column_index]
        piece_type = fill_foreground_color(spot, piece_type)
        printable_board[row_index][column_index] = fill_background_color(spot, piece_type)
      end
    end
  end

  def fill_foreground_color(spot, piece_type)
    piece_color = color(spot)
    return piece_type if piece_color.to_s.strip.empty?

    piece_color == :black ? piece_type.color_fg(:black) : piece_type.color_fg(:cream)
  end

  def fill_background_color(spot, piece_type)
    row, column_index = spot
    row.even? ? piece_type.color_bg(even_row[column_index]) : piece_type.color_bg(odd_row[column_index])
  end
end
