# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts to enter the "Piece Movement".
  class MovementPrompt
    class << self
      using Colorable

      def feedback(active_spots, movable_spots, player_name)
        print_source_piece_prompt(player_name)
        input = gets.chomp.downcase
        allies, enemies = active_spots
        valid_input?(input, allies, movable_spots) ? input : raise_exception(input, enemies)
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      def print_source_piece_prompt(player_name)
        source_piece = <<~SOURCE_PIECE
          Enter the spot name of the piece you want to move.
          You can also 'Save & Exit' (or) 'Quit' the game.

          Press [S] -> #{'SAVE & EXIT'.color_fg(:green)} #{'and [Q] ->'.color_fg(:light_cyan)} #{'QUIT'.color_fg(:red)}
        SOURCE_PIECE
        puts source_piece.color_fg(:light_cyan)

        print player_name.color_fg(:blue) + ', Enter your choice: '.color_fg(:light_cyan)
      end

      def valid_input?(input, allies, movable_spots)
        (allies.include?(input) && movable_spots.include?(input)) || input.eql?('s') || input.eql?('q')
      end

      def raise_exception(input, enemies)
        return raise Errable::EnemyPieceError if enemies.include?(input)

        raise input.match?(/^[a-h][1-8]$/i) ? Errable::IllegalMoveError : Errable::InvalidSpotError
      end
    end
  end
end
