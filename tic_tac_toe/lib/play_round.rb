# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'rounds'

# This class calls other classes (or) modules and operate on those results.
# It acts like a central class & do some actions from the return results of other class & modules.
class PlayRound
  # protected
  #
  # attr_accessor :new_game, :player1, :player2, :player1_profile, :player2_profile, :winner_decided
  #
  # include Rounds
  #
  # def initialize
  #   @new_game = Board.new
  #   @player1 = Player.new
  #   @player2 = Player.new
  #   @winner_decided = false
  #   round_intro
  #   show_sample_board
  #   initiate_player1
  #   initiate_player2
  #   new_game.clear
  #   start_game
  # end
  #
  # def initiate_player1
  #   player1_name = player1.name(1)
  #   player1_flag_symbol = player1.banner(player1_name)
  #   @player1_profile = {
  #     name: player1_name,
  #     banner: player1_flag_symbol,
  #     choice: ''
  #   }
  # end
  #
  # def initiate_player2
  #   player2_name = player2.name(2)
  #   player2_flag_symbol = player2_banner
  #   @player2_profile = {
  #     name: player2_name,
  #     banner: player2_flag_symbol,
  #     choice: ''
  #   }
  # end
  #
  # def player2_banner
  #   return 'O' if player1_profile[:banner].eql?('X')
  #
  #   'X' if player1_profile[:banner].eql?('O')
  # end
  #
  # def player1_turn
  #   player1_profile[:choice] = player1.position_of_choice(player1_profile[:name], player1_profile[:banner])
  #   puts new_game.update(player1_profile[:choice], player1_profile[:banner])
  # end
  #
  # def player2_turn
  #   player2_profile[:choice] = player2.position_of_choice(player2_profile[:name], player2_profile[:banner])
  #   puts new_game.update(player2_profile[:choice], player2_profile[:banner])
  # end
  #
  # public
  #
  # def start_game
  #   1.upto(9) do |number|
  #     player1_turn if number.odd?
  #     player2_turn if number.even?
  #     next unless new_game.won?(number)
  #
  #     round_has_winner(number)
  #     @winner_decided = true
  #     break
  #   end
  #   round_is_tie unless winner_decided
  # end
  #
  # def play_next_round?
  #   Player.available_positions = (1..9).to_a
  #   round_outro.eql?('Y')
  # end
  attr_accessor :board, :player1_name, :player2_name, :player1_choice, :player2_choice

  def initialize(board = Board.new)
    self.board = board
  end

  def show_starter_details
    show_introduction
    show_rules
  end

  def inquire_player_details
    self.player1_name = inquire_player_name(1)
    self.player1_choice = inquire_player_choice(player1_name)
    self.player2_name = inquire_player_name(2)
    self.player2_choice = player1_choice == 'X' ? 'O' : 'X'
  end

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

  def inquire_player_name(player_id)
    print "\nEnter the name of the 'Player-#{player_id}': ".colorize(:light_blue)
    gets.chomp
  end

  def inquire_player_choice(player_name)
    choice = ''
    loop do
      print "\n#{player_name}, Select either 'X -> Cross' (or) 'O -> Nought': ".colorize(:light_magenta)
      choice = gets.chomp.upcase

      return choice if choice.eql?('X') || choice.eql?('O')

      puts 'Invalid Selection'.colorize(:red)
    end
  end
end
