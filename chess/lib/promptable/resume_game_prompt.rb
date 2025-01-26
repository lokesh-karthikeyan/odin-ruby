# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts for "Resume game?" (or) "New game?".
  class ResumeGamePrompt
    class << self
      using Colorable

      def feedback
        print_resume_game_prompt
        input = gets.chomp.downcase
        valid_input?(input) ? input : raise_exception
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      private

      def print_resume_game_prompt
        game_type = <<~GAME_TYPE
          You've a saved game. Would you like to load that game?
          Press [Y] -> #{'Continue Game'.color_fg(:blue)} #{'(or) [N] -> start a'.color_fg(:light_cyan)} #{'New Game'.color_fg(:blue)}
        GAME_TYPE
        puts game_type.color_fg(:light_cyan)

        print 'Enter your choice(y/n): '.color_fg(:light_cyan)
      end

      def valid_input?(input, valid_options = %w[y n]) = valid_options.include?(input)

      def raise_exception = raise Errable::InvalidSelectionError
    end
  end
end
