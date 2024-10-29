# frozen_string_literal: true

require_relative '../feedback'

# This Module contains methods related to terminal interface.
# Such as the messages to be displayed while asking a guess & making a guess.
module TerminalMessages
  include Feedback

  def make_player_to_guess
    print "Enter your guess (#{guess}/#{max_guess}): "
    convert_colors_to_code(gets.chomp)
  end

  def notify_invalid_guess
    puts 'Invalid guess!!! Make a valid guess as per the format with the available colors.'
    make_player_to_guess
  end

  def update_feedback(score)
    score_in_symbols = convert_score_to_symbols(score)
    puts '+----------•----------+'
    print '|'
    score_in_symbols.each { |score_symbol| print "  #{score_symbol}  " }
    puts ' |'
    puts '+----------•----------+'
  end

  def convert_score_to_symbols(score_pegs)
    score_pegs = score_pegs.chars
    score_pegs.map! { |peg| symbols_of_score[peg] }
    score_pegs
  end

  def symbols_of_score
    {
      'B' => "\u{2714}",
      'W' => "\u{25EF}",
      'X' => "\u{1F5D9}"
    }
  end

  def player_is_won
    puts "Awesome! You've won in #{guess} guesses"
    show_logs
  end

  def player_is_lost
    puts "You've lost! All #{guess} guesses have been used."
    show_logs
    puts 'The right combination is:- '
    show_answer
  end

  def show_answer
    answer = convert_code_to_colors(secret_color_code)
    puts '+--------------•--------------+'
    print '|     '
    answer.each { |_color| print '  ⬤  ' }
    puts '     |'
    puts '+--------------•--------------+'
  end

  def make_computer_to_guess; end
end
