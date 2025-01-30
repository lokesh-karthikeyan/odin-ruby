# frozen_string_literal: true

require_relative '../colorable/colorable'

# Methods related to printing board stuff inside the terminal.
module Renderable
  using Colorable

  def print_board
    printable_board.each_with_index do |row_value, row_index|
      print_row_indicators(row_index)
      row_value.each { |piece| print piece }
      print_row_indicators(row_index)
      puts ''
    end
  end

  def print_row_indicators(index) = print row_indicators[index].color_fg(:orange).color_bg(:black)

  def print_top_bottom_borders
    print_separators
    print_column_indicators
    print_separators
    puts ''
  end

  def print_separators = print '  󰡅  '.color_fg(:orange).color_bg(:black)

  def print_column_indicators = column_indicators.each { |column| print column.color_fg(:orange).color_bg(:black) }

  def print_empty_lines = puts "\n\n"
end
