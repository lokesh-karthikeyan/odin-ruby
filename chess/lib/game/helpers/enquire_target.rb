# frozen_string_literal: true

require_relative '../../ai/ai_choice'
require_relative '../../player/player_choice'
require_relative '../../movements/movable'

# Helper Class --> To ask / fetch target spot.
class EnquireTarget
  class << self
    include Movable

    def feedback(active_player, movable_spots)
      player_type = active_player.type
      return computer_choice(active_player) if player_type == :Computer

      player_choice(movable_spots, active_player) if player_type == :Human
    end

    private

    def player_choice(movable_spots, active_player)
      exit_options = %w[q s]

      placement_spots = to_labels(movable_spots)
      target = find_player_choice(placement_spots, active_player.name)

      exit_options.include?(target) ? target : to_coordinates(target)
    end

    def computer_choice(active_player)
      target = find_ai_choice(active_player.name)
      sleep(1)
      to_coordinates(target)
    end

    def find_player_choice(placement_spots, name) = PlayerChoice.target_spot(placement_spots, name)

    def find_ai_choice(name) = AIChoice.target_spot(name)

    def to_labels(positions) = positions.map { |position| spot_label(position).downcase }
  end
end
