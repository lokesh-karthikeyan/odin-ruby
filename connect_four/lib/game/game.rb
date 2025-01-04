# frozen_string_literal: true

require_relative '../displayable/displayable'

# Functionalities related to the game play.
class Game
  attr_accessor :current_player

  def play
    loop do
      position = select_position_prompt
      game_board.update_board(position, current_player.id)
      game_board.display_board(player_disc_id)

      break if game_over?

      switch_players
    end
    conclude_round
  end

  def game_over?
    has_won = game_board.won?(current_player.id)
    has_tied = game_board.tie?
    result[:won] = true if has_won
    result[:tie] = true if has_tied
    has_won || has_tied
  end

  def switch_players = (self.current_player = current_player == player1 ? player2 : player1)

  def valid_choice?(choice) = choice.between?(1, 7) && game_board.valid_position?(choice)

  def conclude_round
    round_conclusion = result.select { |_, value| value }&.keys&.first
    if round_conclusion == :tie
      round_is_tied
    else
      round_is_won
    end
  end

  private

  include Displayable

  attr_accessor :player1, :player2, :game_board, :result

  def initialize(player1, player2, game_board)
    self.player1 = player1
    self.player2 = player2
    self.game_board = game_board
    self.current_player = self.player1
    self.result = { won: false, tie: false }
  end

  def select_position_prompt
    loop do
      print_position_prompt(current_player.name)
      position = gets.chomp.to_i

      return position if valid_choice?(position)

      print_invalid_selection
    end
  end

  def player_disc_id = { player1.id => player1.disc, player2.id => player2.disc }

  def round_is_won = print_winner_announcement(current_player.name, current_player.disc)

  def round_is_tied = print_game_tied_announcement(player1.disc, player2.disc)
end
