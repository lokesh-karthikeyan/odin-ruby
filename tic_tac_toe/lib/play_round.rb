# frozen_string_literal: true

require_relative 'board'
require_relative 'terminal_messages'

# This Class creates an instance of 'Board' class & contains methods to play game.
class PlayRound
  def show_starter_details
    show_introduction
    show_rules
    show_board
  end

  def inquire_player_details
    self.player1_name = inquire_player_name(1)
    self.player1_choice = inquire_player_choice(player1_name)
    self.player2_name = inquire_player_name(2)
    self.player2_choice = player1_choice == 'X' ? 'O' : 'X'
  end

  def start_game
    1.upto(9) do |turn|
      current_player = player_turn(turn)
      place_holder = inquire_place_holder(current_player[:name], current_player[:choice])
      board.update_grids(place_holder, current_player[:choice])
      show_board(board_status)
      return game_won if turn > 4 && won?
    end
    game_lost
  end

  def continue_game?
    choice = ''
    puts '============================================================================================='.colorize(:red)
    loop do
      print "Ready for another round? Press 'Y' for 'Yes', 'N' for 'No': ".colorize(:blue)
      choice = gets.chomp.upcase

      break if %w[Y N].include?(choice)

      invalid_selection
    end
    choice == 'Y'
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

      invalid_selection
    end
  end

  def inquire_place_holder(name, choice)
    place_holder_number = ''
    loop do
      print "\n#{name}, Enter the available placeholder number (1-9) for '#{choice}': ".colorize(:light_cyan)
      place_holder_number = gets.chomp.to_i

      return place_holder_number if place_holder_number.between?(1, 9) && valid_place_holder?(place_holder_number)

      invalid_selection
    end
  end

  def won?
    possibilities.each do |possibility|
      grid1, grid2, grid3 = possibility
      next if board_status[grid1] == ' '

      if aligned?(grid1, grid2, grid3)
        update_winner_profile(board_status[grid1])
        return true
      end
    end
    false
  end

  private

  include TerminalMessages

  attr_accessor :board, :player1_name, :player2_name, :player1_choice, :player2_choice, :winner_profile

  def initialize(board = Board.new) = self.board = board

  def player_turn(turn)
    turn.odd? ? { name: player1_name, choice: player1_choice } : { name: player2_name, choice: player2_choice }
  end

  def valid_place_holder?(place_holder)
    empty_indices = board_status.each_index.select { |index| board_status[index] == ' ' }
    incremented_indices = empty_indices.map { |index| index + 1 }
    incremented_indices.include?(place_holder)
  end

  def board_status = board.game_board

  def possibilities = Board::WINNING_POSSIBILITIES

  def aligned?(index1, index2, index3)
    (board_status[index1] == board_status[index2]) && (board_status[index1] == board_status[index3])
  end

  def update_winner_profile(character)
    player_name = character.eql?(player1_choice) ? player1_name : player2_name
    self.winner_profile = { name: player_name, choice: character }
  end
end
