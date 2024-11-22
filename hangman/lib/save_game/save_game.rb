# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Class handles the 'Saving' & 'Emptying' the data files.
class SaveGame
  using Colorable

  class << self
    def add_data(args)
      Dir.mkdir('game_data') unless Dir.exist?('game_data')
      file_name = 'game_data/resume_game.json'
      File.write(file_name, args.to_json)

      puts ''
      puts 'The Game has been successfully saved! Good Bye!!'.color(:green)
    end

    def remove_data
      File.truncate('game_data/resume_game.json', 0)
    end
  end
end
