# frozen_string_literal: true

# Serialization / Deserialization operations.
module DataTransferable
  # Serializes the given data in a storable format.
  class Serialize
    class << self
      def flush_data = File.truncate('data/game_data.yml', 0)
    end

    def store_data
      Dir.mkdir('data') unless Dir.exist?('data')
      file_name = 'data/game_data.yml'

      File.write(file_name, game_data.to_yaml)
    end

    private

    attr_accessor :game_data

    def initialize(game_data)
      self.game_data = game_data
    end
  end
end
