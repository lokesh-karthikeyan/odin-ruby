# frozen_string_literal: true

# This Module contains methods to handle the current round when the game starts.
module Rounds
  # rubocop:disable Metrics/LineLength
  def round_intro
    puts '                                                                                                           '
    puts '***********************************************************************************************************'.colorize(:yellow)
    puts '* This is a terminal based Tic Tac Toe (also known as “Noughts and Crosses”) game.                        *'.colorize(:yellow)
    puts "* It's a two-player game, where one player is a 'X'(Cross) and the other is 'O'(Noughts).                 *".colorize(:yellow)
    puts "* The winner is decided if 'X' or 'O' is aligned simultaneously in any directions.                        *".colorize(:yellow)
    puts '* Alignment can be either vertical (or) horizontal (or) diagonal.                                         *'.colorize(:yellow)
    puts "* The corresponding symbol's player wins the match.                                                       *".colorize(:yellow)
    puts '***********************************************************************************************************'.colorize(:yellow)
    puts '                                                                                                           '
  end

  def show_sample_board
    puts '+ ------------------------------------------------------------------------------------------------------- +'.colorize(:red)
    puts "| Notice the numbers on the board, the numbers acts as a place where you need to put the 'X' or 'O'.      |".colorize(:red)
    puts '+ ------------------------------------------------------------------------------------------------------- +'.colorize(:red)
    puts '                                                                                                           '
    puts new_game.starter
    puts '                                                                                                           '
  end

  # rubocop:enable Metrics/LineLength
  def winner_profile(number)
    if number.odd?
      player1_profile
    else
      player2_profile
    end
  end

  # rubocop:disable Metrics/LineLength
  def round_has_winner(number)
    winner = winner_profile(number)
    puts '                                                                                                           '
    puts '+ ======================================================================================================= +'.colorize(:green)
    puts "  Hurray! '#{winner[:banner]}' is aligned, and the match was won by '#{winner[:name]}'.".colorize(:green)
    puts '+ ======================================================================================================= +'.colorize(:green)
    puts '                                                                                                           '
  end

  def round_is_tie
    puts '                                                                                                           '
    puts '+ ======================================================================================================= +'.colorize(:light_yellow)
    puts "| It's a good game! This round is a tie!.                                                                 |".colorize(:light_yellow)
    puts '+ ======================================================================================================= +'.colorize(:light_yellow)
    puts '                                                                                                           '
  end

  def round_outro
    play_again = ''
    puts '***********************************************************************************************************'.colorize(:blue)
    loop do
      print "* Ready for another round? Press 'Y' for 'Yes', 'N' for 'No': ".colorize(:blue)
      play_again = gets.chomp.upcase
      puts '***********************************************************************************************************'.colorize(:blue)
      break if %w[Y N].include?(play_again)
    end
    puts '                                                                                                           '
    play_again
  end
  # rubocop:enable Metrics/LineLength
end
