# frozen_string_literal: false

# This Class contains methods to calculate the score of a guess.
class Outcome
  private

  def initialize
    @score = ''
  end

  def correctly_placed_pegs(number_of_pegs)
    @score << 'B' * number_of_pegs
  end

  def misplaced_pegs(number_of_pegs)
    @score << 'W' * number_of_pegs
  end

  def incorrect_pegs
    @score << 'X' until @score.length == 4
  end

  public

  def compute(array_of_pegs)
    correctly_placed_pegs(array_of_pegs.first)
    misplaced_pegs(array_of_pegs.last)
    incorrect_pegs
    @score
  end
end
