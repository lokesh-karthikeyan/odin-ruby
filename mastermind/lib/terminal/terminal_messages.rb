# frozen_string_literal: true

require_relative '../feedback'
require_relative 'colored_text'

# This Module contains methods related to terminal interface.
# Such as the messages to be displayed while asking a guess & making a guess.
module TerminalMessages
  include Feedback
  using ColoredText

  def make_player_to_guess
    print "Enter your guess (#{guess}/#{max_guess}): "
    convert_colors_to_code(gets.chomp)
  end

  def notify_invalid_guess
    puts 'Invalid guess!!! Make a valid guess as per the format with the available colors.'.color_it('red')
    make_player_to_guess
  end

  def update_feedback(score)
    score_in_symbols = convert_score_to_symbols(score)
    puts '+----------•----------+'.color_it('cyan')
    print '|'.color_it('cyan')
    score_in_symbols.each { |score_symbol| print "  #{score_symbol}  " }
    puts ' |'.color_it('cyan')
    puts '+----------•----------+'.color_it('cyan')
  end

  def convert_score_to_symbols(score_pegs)
    score_pegs = score_pegs.chars
    score_pegs.map! { |peg| symbols_of_score[peg] }
    score_pegs
  end

  def symbols_of_score
    {
      'B' => "\u{2714}".color_it('green'),
      'W' => "\u{25EF}".color_it('yellow'),
      'X' => "\u{1F5D9}".color_it('red')
    }
  end

  def player_is_won
    puts "Awesome! You've won in #{guess} guesses".color_it('green')
    show_logs
  end

  def player_is_lost
    puts "You've lost! All #{guess} guesses have been used.".color_it('red')
    show_logs
    puts 'The right combination is:- '.color_it('bright_green')
    show_answer
  end

  def show_answer
    answer = convert_code_to_colors(secret_color_code)
    puts '+--------------•--------------+'.color_it('bright_green')
    print '|     '.color_it('bright_green')
    answer.each { |color| print "  #{color}  " }
    puts '     |'.color_it('bright_green')
    puts '+--------------•--------------+'.color_it('bright_green')
  end

  def make_computer_to_guess; end
end
