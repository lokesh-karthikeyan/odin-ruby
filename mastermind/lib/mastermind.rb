# frozen_string_literal: true

require_relative 'prologue/prologue'
require_relative 'player_makes_guess/player_makes_guess'
require_relative 'computer_makes_guess/computer_makes_guess'
require_relative 'play_another_round/play_another_round'

# This Class holds all the methods when AI plays as a "Decoder" and "Encoder" rules.
class Mastermind
  class << self
    def ai_as_encoder
      Prologue.ai_as_encoder
      PlayerMakesGuess.new
      continue_next_round
    end

    def ai_as_decoder
      Prologue.ai_as_decoder
      ComputerMakesGuess.new
      continue_next_round
    end

    def continue_next_round
      option = PlayAnotherRound.new
      option.choice
    end

    def play_rounds
      choice = ai_as_encoder
      loop do
        choice = ai_as_encoder if choice == 1
        choice = ai_as_decoder if choice == 2
        break if choice.zero?
      end
    end
  end
end

Mastermind.play_rounds
