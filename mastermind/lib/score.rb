# frozen_string_literal: false

# This Class contains methods to calculate the score of a guess.
class Score
  private

  def initialize
    @score = ''
  end

  def matching_pegs(guess, answer)
    answer.length.times do |index|
      next unless guess[index] == answer[index]

      @score << 'B'
      guess[index] = nil
      answer[index] = nil
    end
  end

  def misplaced_pegs(guess, answer)
    answer.length.times do |index|
      next if guess[index].nil?

      if answer.include?(guess[index])
        @score << 'W'
        answer[answer.find_index(guess[index])] = nil
      end
    end
  end

  def no_matches
    @score << 'X' until @score.length == 4
  end

  public

  def calculate(guess, answer)
    guess = guess.chars
    answer = answer.chars
    matching_pegs(guess, answer)
    misplaced_pegs(guess, answer)
    no_matches
    @score
  end
end
