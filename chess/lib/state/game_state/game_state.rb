# frozen_string_literal: true

# Information related to the state of the game.
GameState = Struct.new(:check?, :mate?, :stale_mate?)
