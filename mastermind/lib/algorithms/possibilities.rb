# frozen_string_literal: true

require 'set'

# This Class is part of Donald Knuth's algorithm, it creates all possible combinations.
class Possibilities
  class << self
    def all_possibilities
      total_possible_combinations = Set.new
      %w[1 2 3 4 5 6].repeated_permutation(4) { |permutation| total_possible_combinations << permutation.join }
      total_possible_combinations
    end
  end
end
