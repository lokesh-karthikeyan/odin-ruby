# frozen_string_literal: true

require_relative 'verifiable'
require_relative '../../reportable/reportable'
require_relative '../../data_transferable/serialize'

# Helper Class --> To conclude the current round.
class GameOver
  # Contains scenarios for user quitting / saving the game.
  class EndGame
    class << self
      include Verifiable
      include Reportable

      def save(game_records, player1, player2, game_state)
        logs = game_records.logs
        last_game_state = game_records.last_state
        player1_info = player1.values
        player2_info = player2.values
        game_state_info = game_state.values

        game_data = { logs: logs, last_state: last_game_state, player1: player1_info, player2: player2_info,
                      game_state: game_state_info }

        return print_file_unsaved_message if game_data[:last_state].strip.empty?

        DataTransferable::Serialize.new(game_data).store_data
        print_file_saved_message
      end

      def resign(active_player, inactive_player, game_type)
        print_exit_message(active_player.name, inactive_player.name)

        DataTransferable::Serialize.flush_data if game_type == :resume
      end
    end
  end

  # Contains scenarios for naturally ending game.
  class GameCompleted
    class << self
      include Verifiable
      include Reportable

      attr_accessor :inactive_player, :game_state

      def end_round(inactive_player, three_fold_repetition, fifty_move_rule, game_state, game_type)
        self.inactive_player = inactive_player
        self.game_state = game_state

        DataTransferable::Serialize.flush_data if game_type == :resume

        return print_check_mate_message(inactive_player.name) if mate?
        return print_stale_mate_message if stale_mate?
        return print_three_fold_repetition_message if three_fold_repetition

        print_fifty_move_rule_message if fifty_move_rule
      end
    end
  end
end
