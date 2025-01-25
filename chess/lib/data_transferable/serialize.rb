# frozen_string_literal: true

# Serialization / Deserialization operations.
module DataTransferable
  # Serializes the given data in a storable format.
  class Serialize
    def store_data
      Dir.mkdir('data') unless Dir.exist?('data')
      self.file_name = 'data/game_data.yml'
      File.write(file_name, game_data.to_yaml)
    end

    def flush_data = File.truncate(file_name, 0)

    private

    attr_accessor :game_data, :file_name

    def initialize(game_data)
      self.game_data = game_data
    end
  end
end
