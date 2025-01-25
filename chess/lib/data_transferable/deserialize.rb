# frozen_string_literal: true

# Serialization / Deserialization operations.
module DataTransferable
  # Deserializes the game data from a "YAML" file.
  class Deserialize
    def logs = game_data[:logs]

    def last_state = game_data[:last_state]

    def player1 = game_data[:player1]

    def player2 = game_data[:player2]

    def game_state = game_data[:game_state]

    private

    attr_accessor :game_data

    def initialize
      self.game_data = YAML.load_file('data/game_data.yml') if File.exist?('data/game_data.yml')
    end
  end
end
