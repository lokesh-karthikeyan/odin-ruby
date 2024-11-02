# frozen_string_literal: true

# This Class enumerates over the possible answer's each score count and gets the one with maximum score.
# Example -> {"1333"=>317, "1334"=>276, "1335"=>276}
class WorstOutcomes
  def initialize
    @worst_outcome_list = {}
  end

  def worst_outcome_of_a_possibility(score_list)
    score_list.each_pair do |guess, score|
      maximum_score_of_a_guess = score.max_by { |_key, value| value }
      @worst_outcome_list[guess] = maximum_score_of_a_guess.last
    end
    @worst_outcome_list
  end
end
