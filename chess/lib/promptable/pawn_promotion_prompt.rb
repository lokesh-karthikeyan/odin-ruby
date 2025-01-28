# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts to select a piece for "Pawn Promotion".
  class PawnPromotionPrompt
    class << self
      using Colorable

      def feedback(player_name)
        print_pawn_promotion_prompt(player_name)
        input = gets.chomp.downcase
        valid_input?(input) ? input : raise_exception
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      private

      def print_pawn_promotion_prompt(player_name)
        pawn_promotion = <<~PAWN_PROMOTION
          The moved pawn is now eligible for a #{'Promotion'.color_fg(:green)}#{'.'.color_fg(:light_cyan)}
          #{'You can now replace this pawn with a'.color_fg(:light_cyan)} #{pieces}
        PAWN_PROMOTION
        puts pawn_promotion.color_fg(:light_cyan)
        puts choices

        print player_name.color_fg(:blue) + ', Enter your choice(q/r/b/k): '.color_fg(:light_cyan)
      end

      def pieces
        '"Queen"'.color_fg(:yellow) + ' (or) '.color_fg(:light_cyan) +
          '"Rook"'.color_fg(:yellow) + ' (or) '.color_fg(:light_cyan) +
          '"Bishop"'.color_fg(:yellow) + ' (or) '.color_fg(:light_cyan) +
          '"Knight"'.color_fg(:yellow) + '.'.color_fg(:light_cyan)
      end

      def choices
        "Enter #{'[Q]'.color_fg(:blue)}".color_fg(:light_cyan) +
          " -> Queen (or) #{'[R]'.color_fg(:blue)}".color_fg(:light_cyan) +
          " -> Rook (or) #{'[B]'.color_fg(:blue)}".color_fg(:light_cyan) +
          " -> Bishop (or) #{'[K]'.color_fg(:blue)}".color_fg(:light_cyan) +
          ' -> Knight'.color_fg(:light_cyan)
      end

      def valid_input?(input, valid_options = %w[q r b k]) = valid_options.include?(input)

      def raise_exception = raise Errable::InvalidSelectionError
    end
  end
end
