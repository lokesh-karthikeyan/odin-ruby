# frozen_string_literal: true

require_relative '../../score'

# Here, all the possibilities will loop over each possibility to count each possibilities's various score & its count.
# Example -> {"1333"=>{"BXXX"=>125, "BBXX"=>75, "BBBX"=>15, "BBBB"=>1}}
class ScoreCount
  def initialize
    @possible_scores = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  def count_possible_scores(possibilities)
    possibilities.each do |possible_guess|
      possibilities.each do |possible_answer|
        score = Score.new
        current_score = score.calculate(possible_guess, possible_answer)
        @possible_scores[possible_guess][current_score] += 1
      end
    end
    @possible_scores
  end
end
