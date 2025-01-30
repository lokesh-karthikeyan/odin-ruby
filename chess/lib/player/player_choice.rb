# frozen_string_literal: true

require_relative '../promptable/movement_prompt'
require_relative '../promptable/placement_prompt'
require_relative '../promptable/pawn_promotion_prompt'

# Calls prompt classes prompts that are related to a player inside the game play.
class PlayerChoice
  class << self
    def source_piece(active_spots, movable_spots, player_name)
      Promptable::MovementPrompt.feedback(active_spots, movable_spots, player_name)
    end

    def target_spot(placement_spots, player_name)
      Promptable::PlacementPrompt.feedback(placement_spots, player_name)
    end

    def pawn_promotion(player_name)
      Promptable::PawnPromotionPrompt.feedback(player_name)
    end
  end
end
