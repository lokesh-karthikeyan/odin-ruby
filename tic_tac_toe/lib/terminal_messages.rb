# frozen_string_literal: true

# This Module contains methods that prints messages inside the terminal.
module TerminalMessages
  def invalid_selection = puts('Invalid Selection'.colorize(:red))

  def show_introduction
    introduction = <<~INTRO
      ***********************************************************************************************************
      * This is a terminal based Tic Tac Toe (also known as “Noughts and Crosses”) game.                        *
      * It's a two-player game, where one player is a 'X'(Cross) and the other is 'O'(Noughts).                 *
      * The winner is decided if 'X' or 'O' is aligned simultaneously in any directions.                        *
      * Alignment can be either vertical (or) horizontal (or) diagonal.                                         *
      * The corresponding symbol's player wins the match.                                                       *
      ***********************************************************************************************************
    INTRO
    puts introduction.colorize(:yellow)
  end

  def show_rules
    rules = <<~RULES
      + ------------------------------------------------------------------------------------------------------- +
      | Notice the numbers on the board, the numbers acts as a place where you need to put the 'X' or 'O'.      |
      + ------------------------------------------------------------------------------------------------------- +
    RULES
    print rules.colorize(:red)
  end

  def show_board(grids = %w[1 2 3 4 5 6 7 8 9])
    display_board = <<~BOARD

      #{border}
      #{row_in_strings(grids[0], grids[1], grids[2])}
      |         ---+---+---         |
      #{row_in_strings(grids[3], grids[4], grids[5])}
      |         ---+---+---         |
      #{row_in_strings(grids[6], grids[7], grids[8])}
      #{border}
    BOARD
    print display_board.colorize(:light_white)
  end

  def game_won
    congrats_to_winner = <<~CONGRATS

      + ======================================================================================================= +
        Hurray! '#{winner_profile[:choice]}' is aligned, and the match was won by '#{winner_profile[:name]}'.
      + ======================================================================================================= +
    CONGRATS
    puts congrats_to_winner.colorize(:green)
  end

  def game_lost
    game_tied = <<~TIE

      + ======================================================================================================= +
      | It's a good game! This round is a tie!.                                                                 |
      + ======================================================================================================= +
    TIE
    puts game_tied.colorize(:light_yellow)
  end

  private

  def border = '+ --------------------------- +'

  def row_in_strings(grid1, grid2, grid3) = "|          #{grid1} | #{grid2} | #{grid3}          |"
end
