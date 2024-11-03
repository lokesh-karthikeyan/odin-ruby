# frozen_string_literal: true

require_relative 'possibilities'
require_relative 'filter_possibilities'
require_relative 'minimax'

# This Class contains methods related to Donald Knuth's worst case algorithm.
# It acts like a central class to call other classes & modules.
class KnuthAlgorithm
  # Step - 1 ==> Create the set S of 1,296 possible codes {1111, 1112, ... 6665, 6666}.
  def initialize
    @all_possibilities = Possibilities.all_possibilities
  end

  # Step - 2 ==> Start with initial guess 1122.
  def initial_guess
    '1122'
  end

  # Step - 5 ==> Remove any possibilities that doesn't give the same score.
  def select_valid_possibilities(possibilities, guess, score)
    @all_possibilities = FilterPossibilities.remove_impossible_answers(possibilities, guess, score)
  end

  # Step - 6 ==> The next guess is chosen by the "Minimax" technique.
  # It chooses a guess that has the least worst response score.
  def next_guess(current_guess, current_score)
    select_valid_possibilities(@all_possibilities, current_guess, current_score)
    Minimax.new.best_of_worst_possibility(@all_possibilities)
  end
end
