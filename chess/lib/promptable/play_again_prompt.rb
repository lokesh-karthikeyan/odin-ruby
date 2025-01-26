# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts for playing another round.
  class PlayAgainPrompt
    class << self
      using Colorable

      def feedback
        print_play_again_prompt
        input = gets.chomp.downcase
        valid_input?(input) ? input : raise_exception
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      private

      def print_play_again_prompt
        play_another_round = <<~NEXT_ROUND
          Ready for another round?
          Press [Y] -> #{'YES'.color_fg(:green)} #{'and [N] ->'.color_fg(:light_cyan)} #{'NO'.color_fg(:red)}
        NEXT_ROUND
        puts play_another_round.color_fg(:light_cyan)

        print 'Enter your choice(y/n): '.color_fg(:light_cyan)
      end

      def valid_input?(input, valid_options = %w[y n]) = valid_options.include?(input)

      def raise_exception = raise Errable::InvalidSelectionError
    end
  end
end
