# frozen_string_literal: false

# This Module handles the scores (or) feedback related methods.
# Converting the color codes to actual color name (or) vice-versa & comparing the guess with the secret code.
module Feedback
  def outcome_of_the_guess(guess, answer)
    score = ''
    guess = guess.chars
    answer = answer.chars
    score << black_pegs_count(guess, answer)
    score << white_pegs_count(guess, answer)
    score << 'X' until score.length == 4
    score.chars.sort.join
  end

  def black_pegs_count(guess, answer)
    score = ''
    answer.length.times do |index|
      next unless guess[index] == answer[index]

      score << 'B'
      guess[index] = nil
      answer[index] = nil
    end
    score
  end

  def white_pegs_count(guess, answer)
    score = ''
    answer.length.times do |index|
      next if guess[index].nil?

      if answer.include?(guess[index])
        score << 'W'
        answer[answer.find_index(guess[index])] = nil
      end
    end
    score
  end
end
