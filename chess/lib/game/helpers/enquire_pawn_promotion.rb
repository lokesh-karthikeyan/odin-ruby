# frozen_string_literal: true

require_relative '../../ai/ai_choice'
require_relative '../../player/player_choice'

# Helper Class --> To ask / fetch the name of the piece to be promoted.
class EnquirePawnPromotion
  class << self
    def piece_type(active_player)
      name = active_player.name
      piece = active_player.type.eql?(:Human) ? find_player_choice(name) : find_computer_choice(name)
      piece = piece.eql?('k') ? 'n' : piece

      active_player.color == :white ? piece.upcase : piece.downcase
    end

    private

    def find_player_choice(name) = PlayerChoice.pawn_promotion(name)

    def find_computer_choice(name) = AIChoice.pawn_promotion(name)
  end
end
