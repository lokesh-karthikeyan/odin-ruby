# frozen_string_literal: true

require 'set'
require_relative 'minimax'

# Donald Knuth's algorithm to guess the correct code within five guesses.
class WorstCase
  private

  def initialize
    @all_possibilities = Set.new
    %w[1 2 3 4 5 6].repeated_permutation(4) { |permutation| all_possibilities << permutation.join }
    @current_possibilities = all_possibilities.dup
  end

  def filter_possibilities(guess, feedback_of_the_guess)
    current_possibilities.reject! { |possibility| possibility == guess }

    current_possibilities.keep_if do |possibility|
      feedback_of_the_guess == outcome_of_the_guess(possibility, guess)
    end
  end

  public

  def guess
    potential_answers = Minimax.new(current_possibilities, all_possibilities)
    potential_answers.best_guess
  end

  attr_reader :all_possibilities, :current_possibilities
end
