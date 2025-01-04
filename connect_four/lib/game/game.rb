# frozen_string_literal: true

require_relative '../displayable/displayable'

# Functionalities related to the game play.
class Game
  def game_over?
    has_won = game_board.won?(current_player.id)
    has_tied = game_board.tie?
    result[:won] = true if has_won
    result[:tie] = true if has_tied
    has_won || has_tied
  end

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

  attr_accessor :player1, :player2, :game_board, :current_player, :result

  def initialize(player1, player2, game_board)
    self.player1 = player1
    self.player2 = player2
    self.game_board = game_board
    self.current_player = self.player1
    self.result = { won: false, tie: false }
  end

  def round_is_won; end

  def round_is_tied; end
end
