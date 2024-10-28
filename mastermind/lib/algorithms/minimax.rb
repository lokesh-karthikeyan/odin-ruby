# frozen_string_literal: true

# Minimax algorithm to determine the next possible guess.
class Minimax
  private

  attr_reader :current_possibilities, :all_possibilities
  attr_accessor :probability_of_scores

  include Feedback

  def initialize(current_possibilities, all_possibilities)
    @current_possibilities = current_possibilities
    @all_possibilities = all_possibilities
    @probability_of_scores = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  # From the list of current_possibilities, make each possibility to enumerate through all_possibilities.
  # For each guess, note the probability of each different score.
  # Example -> {"1333"=>{"BXXX"=>125, "BBXX"=>75, "BBBX"=>15, "BBBB"=>1}}
  def generate_probabilities_of_scores
    current_possibilities.each do |possible_guess|
      all_possibilities.each do |possible_answer|
        score = outcome_of_the_guess(possible_guess, possible_answer)
        probability_of_scores[possible_guess][score] += 1
      end
    end
  end

  # For each guess, it finds the guess that yields high probable count of answers.
  # In other words, the worst case -> where the guess will only eliminate a few possibilities.
  # Example -> {"1333"=>317, "1334"=>276, "1335"=>276}
  def worst_outcome_count_for_a_possibility
    max_score_of_a_possibility = {}
    probability_of_scores.each_pair do |guess, score|
      maximum_of_scores = score.max_by { |_key, value| value }
      max_score_of_a_possibility[guess] = maximum_of_scores.last
    end
    max_score_of_a_possibility
  end

  # Get the minimum from the worst case list.
  def best_of_the_worst_outcome(worst_possibilities)
    worst_possibilities.key(worst_possibilities.values.min)
  end

  public

  def best_guess
    generate_probabilities_of_scores
    max_score_list_of_each_possibility = worst_outcome_count_for_a_possibility
    best_of_the_worst_outcome(max_score_list_of_each_possibility)
  end
end
