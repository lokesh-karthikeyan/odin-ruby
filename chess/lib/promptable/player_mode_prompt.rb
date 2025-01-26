# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts for "Player vs Player" (or) "Player vs AI" mode.
  class PlayerModePrompt
    class << self
      using Colorable

      def feedback
        print_player_mode_prompt
        input = gets.chomp
        valid_input?(input) ? input : raise_exception
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      private

      def print_player_mode_prompt
        player_mode = <<~PLAYER_MODE
          You can either play a single player game -> "Player vs AI" (or) a two player game -> "Player vs Player".
          Select [1] -> #{'Single Player'.color_fg(:blue)} #{'(or) [2] ->'.color_fg(:light_cyan)} #{'Two Player'.color_fg(:blue)}
        PLAYER_MODE
        puts player_mode.color_fg(:light_cyan)

        print 'Enter your choice(1/2): '.color_fg(:light_cyan)
      end

      def valid_input?(input, valid_options = %w[1 2]) = valid_options.include?(input)

      def raise_exception = raise Errable::InvalidSelectionError
    end
  end
end
