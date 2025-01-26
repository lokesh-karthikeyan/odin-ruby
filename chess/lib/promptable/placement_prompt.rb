# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts to enter the "Piece Placement".
  class PlacementPrompt
    class << self
      using Colorable

      def feedback(placement_spots, player_name)
        print_target_spot_prompt(player_name)
        input = gets.chomp.downcase
        valid_input?(input, placement_spots) ? input : raise_exception(input, placement_spots)
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      def print_target_spot_prompt(player_name)
        target_spot = <<~TARGET_SPOT
          Enter the spot name to place the piece.
          You can also 'Save & Exit' (or) 'Quit' the game.

          Press [S] -> #{'SAVE & EXIT'.color_fg(:green)} #{'and [Q] ->'.color_fg(:light_cyan)} #{'QUIT'.color_fg(:red)}
        TARGET_SPOT
        puts target_spot.color_fg(:light_cyan)

        print player_name.color_fg(:blue) + ', Enter your choice: '.color_fg(:light_cyan)
      end

      def valid_input?(input, placement_spots) = placement_spots.include?(input) || input.eql?('s') || input.eql?('q')

      def raise_exception(input, _placement_spots)
        raise input.match?(/^[a-h][1-8]$/i) ? Errable::IllegalMoveError : Errable::InvalidSpotError
      end
    end
  end
end
