# frozen_string_literal: true

require_relative '../score'

# This Class filters out the possibilities from the total possibilities list, it's part of Donald Knuth's algorithm.
class FilterPossibilities
  class << self
    def remove_impossible_answers(possibilities_list, guessed_code, score)
      possibilities_list.reject! { |possibility| possibility == guessed_code }

      possibilities_list.keep_if do |possibility|
        current_score = Score.new
        current_score.calculate(possibility, guessed_code) == score
      end

      possibilities_list
    end
  end
end
