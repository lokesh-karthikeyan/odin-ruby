# frozen_string_literal: true

require_relative '../errable/errable'
require_relative '../colorable/colorable'

# Enquires the player's input.
module Promptable
  # Prompts for "Player Name".
  class PlayerNamePrompt
    class << self
      using Colorable

      def feedback(id)
        print_player_name_prompt(id)
        input = gets.chomp
        valid_input?(input) ? input : raise_exception
      rescue StandardError => e
        puts e.message.color_fg(:red)
        retry
      end

      private

      def print_player_name_prompt(id)
        player_name = <<~PLAYER_NAME
          #{'Player-1'.color_fg(:blue)} #{'->'.color_fg(:light_cyan)} \
          #{'White'.color_bg(:cream).color_fg(:blue)} #{'colored pieces and'.color_fg(:light_cyan)} \
          #{'Player-2'.color_fg(:blue)} #{'->'.color_fg(:light_cyan)} \
          #{'Black'.color_bg(:black).color_fg(:blue)} #{'colored pieces.'.color_fg(:light_cyan)}
        PLAYER_NAME
        puts player_name.color_fg(:light_cyan)

        print enquire_input(id)
      end

      def enquire_input(id)
        "Enter #{"Player-#{id}".color_fg(:blue)}".color_fg(:light_cyan) + ' name: '.color_fg(:light_cyan)
      end

      def valid_input?(input) = input.match?(/^[a-zA-Z0-9]+$/)

      def raise_exception = raise Errable::IllegalCharacterError
    end
  end
end
