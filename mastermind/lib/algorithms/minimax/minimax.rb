# frozen_string_literal: true

require_relative 'score_count'
require_relative 'worst_outcomes'

# This Class uses "MiniMax" technique to compute the next best possible answer.
class Minimax
  def initialize
    @score_list = ScoreCount.new
    @worst_cases = WorstOutcomes.new
  end

  def best_of_worst_possibility(possibilities_list)
    potential_answers = @score_list.count_possible_scores(possibilities_list)
    worst_case_list = @worst_cases.worst_outcome_of_a_possibility(potential_answers)
    worst_case_list.key(worst_case_list.values.min)
  end
end
