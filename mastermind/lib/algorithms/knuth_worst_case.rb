# frozen_string_literal: true

require 'set'

# Donald Knuth's algorithm to guess the correct code within five guesses.
class WorstCase
  private

  attr_reader :possibilities, :probability_of_a_possibility

  def initialize
    possibilities = Set.new
    %w[1 2 3 4 5 6].repeated_permutation(4) { |permutation| possibilities << permutation.join }
    generate_dictionary_of_probabilities
  end

  def generate_dictionary_of_probabilities; end
end
