# frozen_string_literal: true

require_relative 'game_factory'
require_relative 'promptable/player_mode_prompt'
require_relative 'promptable/player_name_prompt'

# Helper Class --> To load a "New game" (or) "Resume game".
class LoadGame
  class << self
    def initiate_board_setup(board_klass)
      board_klass.create
      piece_placements, movements = GameFactory.generate_initial_setup
      board_state = board_klass.place_pieces(piece_placements)
      movement_state = GameFactory.create_move_state(movements)
      [board_state, movement_state]
    end

    def resume_prior_board_state(board_klass, fen_string)
      piece_placements, movements = GameFactory.resolve_fen(fen_string)
      board_state = board_klass.place_pieces(piece_placements)

      movement_state = GameFactory.create_move_state(movements)

      [board_state, movement_state]
    end

    def resume_game
      saved_game_info = GameFactory.load_game
      player_profiles = { player1: saved_game_info.player1, player2: saved_game_info.player2 }
      player1, player2 = load_player_details(player_profiles)

      game_records = GameFactory.create_game_records
      game_records.update_state(saved_game_info.last_state, saved_game_info.logs)

      check_state, mate_state, stale_mate_state = saved_game_info.game_state
      game_state = GameFactory.create_game_state(check: check_state, mate: mate_state, stale_mate: stale_mate_state)

      [player1, player2, game_records, game_state, saved_game_info.last_state]
    end

    def new_game
      user_feedback = Promptable::PlayerModePrompt.feedback.to_i
      player_profiles = player_vs_ai if user_feedback.eql?(1)
      player_profiles = player_vs_player if user_feedback.eql?(2)
      player1, player2 = player_profiles

      game_records = GameFactory.create_game_records
      game_state = GameFactory.create_game_state
      [player1, player2, game_records, game_state]
    end

    private

    def load_player_details(player_details)
      player1_name, player1_color, player1_type = player_details[:player1]
      player2_name, player2_color, player2_type = player_details[:player2]

      player1_profile = GameFactory.create_player_profiles(player1_name, player1_color, player1_type)
      player2_profile = GameFactory.create_player_profiles(player2_name, player2_color, player2_type)
      [player1_profile, player2_profile]
    end

    def player_vs_ai
      player1_name = Promptable::PlayerNamePrompt.feedback(1)

      player1_details = [player1_name, :white, :Human]
      player2_details = ['AI', :black, :Computer]

      load_player_details({ player1: player1_details, player2: player2_details })
    end

    def player_vs_player
      player1_name = Promptable::PlayerNamePrompt.feedback(1)
      player2_name = Promptable::PlayerNamePrompt.feedback(2)

      player1_details = [player1_name, :white, :Human]
      player2_details = [player2_name, :black, :Human]

      load_player_details({ player1: player1_details, player2: player2_details })
    end
  end
end
