# frozen_string_literal: true

require_relative 'board/board'
require_relative 'render/render'
require_relative 'state/state'
require_relative 'game_records/game_records'
require_relative 'player/player'
require_relative 'game/game'

require_relative 'fen/fen'
require_relative 'data_transferable/deserialize'

# Factory class that creates instances of other classes / return class itself.
class GameFactory
  class << self
    def generate_board = Board

    def create_renderer(board) = Render.new(board)

    def generate_initial_setup
      fen_string = File.read('fen.txt').chomp
      FEN.resolve(fen_string)
    end

    def resolve_fen(fen_string) = FEN.resolve(fen_string)

    def create_move_state(arguments) = State.create_move_state(arguments)

    def load_game = DataTransferable::Deserialize.new

    def create_game_records = GameRecords.new

    def create_game_state(check: false, mate: false, stale_mate: false)
      State.create_game_state(check: check, mate: mate, stale_mate: stale_mate)
    end

    def create_player_profiles(name, color, type) = Player.new(name, color, type)

    def create_game_instance(arguments) = Game.new(arguments)
  end
end
