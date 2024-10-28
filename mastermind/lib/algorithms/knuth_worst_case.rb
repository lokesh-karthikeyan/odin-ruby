# frozen_string_literal: true

require 'set'
require_relative '../feedback'
require_relative 'minimax'

# Donald Knuth's algorithm to guess the correct code within five guesses.
# Find the list of worst case guesses & choose the least worst case guess.
class WorstCase
  attr_reader :all_possibilities, :current_possibilities

  def initialize
    @all_possibilities = Set.new
    %w[1 2 3 4 5 6].repeated_permutation(4) { |permutation| all_possibilities << permutation.join }
    @current_possibilities = all_possibilities.dup
  end

  include Feedback

  # Remove the current_guessed_code if it's not the right answer & keep only the codes that has same feedback.
  def filter_possibilities(guessed_code, feedback_of_the_guess)
    current_possibilities.reject! { |possibility| possibility == guessed_code }

    current_possibilities.keep_if do |possibile_guess|
      feedback_of_the_guess == outcome_of_the_guess(possibile_guess, guessed_code)
    end
  end

  def guess
    potential_answers = Minimax.new(current_possibilities, all_possibilities)
    potential_answers.best_guess
  end
end
