# frozen_string_literal: true

require_relative 'player/player_queryable'
require_relative 'displayable/displayable'
require_relative 'game_factory'

# Controls the entire flow of the application from intro -> outro.
class ConnectFour
  include PlayerQueryable

  def start_game
    loop do
      GameFactory.create_prelude
      create_player_profiles
      win_conditions = GameFactory.create_win_conditions
      game_board = GameFactory.create_game_board(win_conditions)
      current_game = GameFactory.create_game(player1, player2, game_board)
      current_game.play

      break unless continue_game?
    end
  end

  def create_player_profiles
    player1_details = enquire_player1_details
    player2_details = enquire_player2_details(player1_details[:disc_color])
    self.player1 = GameFactory.create_player(player1_details[:id], player1_details[:name],
                                             player1_details[:disc_color])
    self.player2 = GameFactory.create_player(player2_details[:id], player2_details[:name],
                                             player2_details[:disc_color])
  end

  def continue_game?
    choice = ''
    loop do
      next_game_prompt
      choice = gets.chomp.downcase

      break if %w[y n].include?(choice)

      print_invalid_selection
    end
    choice == 'y'
  end

  private

  attr_accessor :player1, :player2
end

ConnectFour.new.start_game
