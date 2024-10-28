# frozen_string_literal: true

# Minimax algorithm to determine the next possible guess.
# For the current possible guesses, each guess enumerates through all the possibility to determine the next best guess.
# The guess is chosen from the best of the worst cases.
# Worst case is that maximum number of outcomes a guess can have.
# Or least possibilities is eliminated from that guess, thus still retains many possibilities.
class Minimax
  private

  attr_reader :current_possibilities, :all_possibilities
  attr_accessor :outcome_of_a_possibility, :probable_outcomes_of_a_possibility

  def initialize(current_possibilities, all_possibilities)
    @current_possibilities = current_possibilities
    @all_possibilities = all_possibilities
    @outcome_of_a_possibility = Hash.new { |hash, key| hash[key] = {} }
    @probable_outcomes_of_a_possibility = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  def generate_possibilities_and_probable_outcomes
    current_possibilities.each do |possible_guess|
      all_possibilities.each do |possible_answer|
        score = outcome_of_the_guess(possible_guess, possible_answer)
        outcome_of_a_possibility[possible_guess.to_sym][possible_answer.to_sym] = score
        probable_outcomes_of_a_possibility[possible_guess.to_sym][score.to_sym] += 1
      end
    end
  end

  def worst_outcome_of_a_possibility
    max_score_of_a_possibility = {}
    probable_outcomes_of_a_possibility.each_pair do |guess, score|
      maximum_of_scores = score.max_by { |_key, value| value }
      max_score_of_a_possibility[guess] = maximum_of_scores.last
    end
    max_score_of_a_possibility
  end

  def best_of_the_worst_outcome(worst_possibilities)
    worst_possibilities.key(worst_possibilities.value.min)
  end

  public

  def best_guess
    generate_possibilities_and_probable_outcomes
    max_score_list_of_each_possibility = worst_outcome_of_a_possibility
    best_of_the_worst_outcome(max_score_list_of_each_possibility)
  end
end
