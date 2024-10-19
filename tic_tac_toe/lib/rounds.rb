# frozen_string_literal: true

# This Module contains methods to handle the current round when the game starts.
module Rounds
  def round_intro
    puts '                                                                                                           '
    puts '***********************************************************************************************************'
    puts '* This is a terminal based Tic Tac Toe (also known as “Noughts and Crosses”) game.                        *'
    puts "* It's a two-player game, where one player is a 'X'(Cross) and the other is 'O'(Noughts).                 *"
    puts "* The winner is decided if 'X' or 'O' is aligned simultaneously in any directions.                        *"
    puts '* Alignment can be either vertical (or) horizontal (or) diagonal.                                         *'
    puts "* The corresponding symbol's player wins the match.                                                       *"
    puts '***********************************************************************************************************'
    puts '                                                                                                           '
  end

  def show_sample_board
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    puts "| Notice the numbers on the board, the numbers acts as a place where you need to put the 'X' or 'O'.      |"
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    puts '                                                                                                           '
    puts new_game.starter
    puts '                                                                                                           '
  end

  def winner_profile(number)
    if number.odd?
      player1_profile
    else
      player2_profile
    end
  end

  def round_has_winner(number)
    winner = winner_profile(number)
    puts '                                                                                                           '
    puts '+ ======================================================================================================= +'
    puts "  Hurray! '#{winner[:banner]}' is aligned, and the match was won by '#{winner[:name]}'."
    puts '+ ======================================================================================================= +'
    puts '                                                                                                           '
  end

  def round_is_tie
    puts '                                                                                                           '
    puts '+ ======================================================================================================= +'
    puts "| It's a good game! This round is a tie!.                                                                 |"
    puts '+ ======================================================================================================= +'
    puts '                                                                                                           '
  end

  def round_outro
    play_again = ''
    puts '***********************************************************************************************************'
    loop do
      print "* Ready for another round? Press 'Y' for 'Yes', 'N' for 'No': "
      play_again = gets.chomp.upcase
      puts '***********************************************************************************************************'
      break if %w[Y N].include?(play_again)
    end
    puts '                                                                                                           '
    play_again
  end
end
