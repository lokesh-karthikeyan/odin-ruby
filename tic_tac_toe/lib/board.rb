# frozen_string_literal: true

require_relative 'is_aligned'

# This class contains the board data in a format that can be shown in display.
# The board values are updated based on various scenarios such as while starting and updating and finishing each rounds.
class Board
  include IsAligned

  protected

  attr_reader :options

  def initialize
    @options = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' ' }
  end

  def row1
    " #{options[1]} | #{options[2]} | #{options[3]} "
  end

  def row2
    " #{options[4]} | #{options[5]} | #{options[6]} "
  end

  def row3
    " #{options[7]} | #{options[8]} | #{options[9]} "
  end

  def separators
    '---+---+---'
  end

  def board
    "+ ------------------------------------------------------------------------------------------------------- +
|                                                                                                         |
|                                              #{row1}                                                |
|                                              #{separators}                                                |
|                                              #{row2}                                                |
|                                              #{separators}                                                |
|                                              #{row3}                                                |
|                                                                                                         |
+ ------------------------------------------------------------------------------------------------------- +"
  end

  public

  def starter
    1.upto(options.length) { |number| options[number] = number }
    board
  end

  def update(position, player_flag)
    options[position] = player_flag
    board
  end

  def clear
    1.upto(options.length) { |number| options[number] = ' ' }
    board
  end
end
