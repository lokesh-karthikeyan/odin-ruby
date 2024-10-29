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

  def color_codes
    {
      'green' => '1',
      'red' => '2',
      'blue' => '3',
      'purple' => '4',
      'orange' => '5',
      'yellow' => '6'
    }
  end

  def convert_colors_to_code(guess_of_colors)
    guess_of_colors = guess_of_colors.tr(' ', '').downcase.split(',')
    guess_of_colors.map! do |color|
      color_codes[color]
    end
    guess_of_colors.join
  end

  def convert_code_to_colors(guess_of_codes)
    guess_of_codes = guess_of_codes.chars
    guess_of_codes.map! do |code|
      color_codes.key(code)
    end
    guess_of_codes
  end
end
