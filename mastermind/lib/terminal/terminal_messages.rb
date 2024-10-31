# frozen_string_literal: true

require_relative '../feedback'
require_relative 'colored_text'
require_relative 'beautify_logs'
require_relative 'convert_to_symbols'

# This Module contains messages related to terminal interface invloving player as a decoder.
# Such as the messages to be displayed while asking a guess and showing feedback.
module TerminalMessages
  include Feedback
  include BeautifyLogs
  include ConvertToSymbols
  using ColoredText

  def introduction
    print_mastermind_title
    puts "You're a #{'CODE BREAKER'.color_it('steel_blue')} and I'm the #{'CODE MAKER'.color_it('steel_blue')}.".color_it('light_cyan') # rubocop:disable Layout/LineLength
    puts "Can you guess the right color combination within #{'12'.color_it('red')} moves?".color_it('light_cyan')
    puts ''
    show_rules
  end

  def show_rules
    print 'NOTE: '.color_it('red')
    puts "Each color in a guess should be separated by a #{'COMMA(,)'.color_it('steel_blue')}.".color_it('light_cyan')
    puts ''
    show_guess_format
    puts ''
    show_available_colors
    puts ''
  end

  # rubocop:disable Layout/LineLength
  def show_guess_format
    puts "For exmaple:- #{'Red, Green, Blue, Purple'.color_it('red')} or #{'YELLOW,PURPLE,BLUE,BLUE'.color_it('red')}.".color_it('light_cyan')
    puts "You can either use #{'UPCASE'.color_it('steel_blue')} or #{'DOWNCASE'.color_it('steel_blue')}.".color_it('light_cyan')
  end
  # rubocop:enable Layout/LineLength

  def show_available_colors
    print 'The available colors are'.color_it('light_cyan')
    colors.each_value { |colored_color| print " #{colored_color}" }
    puts '.'.color_it('light_cyan')
  end

  def make_player_to_guess
    print "Enter your guess (#{guess}/#{max_guess}): "
    convert_colors_to_code(gets.chomp)
  end

  def notify_invalid_guess
    puts 'Invalid guess!!! Make a valid guess as per the format with the available colors.'.color_it('red')
    make_player_to_guess
  end

  def update_feedback(score)
    score_in_symbols = score_to_colored_symbols(score)
    puts ''
    puts '+----------•----------+'.color_it('cyan')
    print '|'.color_it('cyan')
    score_in_symbols.each { |score_symbol| print "  #{score_symbol}  " }
    puts ' |'.color_it('cyan')
    puts '+----------•----------+'.color_it('cyan')
    puts ''
  end

  def player_is_won
    puts ''
    puts "Awesome! You've won in #{guess - 1} guesses.".color_it('green')
    puts ''
    show_logs
  end

  def player_is_lost
    puts ''
    puts "You've lost! All #{guess - 1} guesses have been used.".color_it('red')
    puts ''
    show_logs
    puts ''
    puts 'The right combination is:- '.color_it('bright_green')
    puts ''
    show_answer
  end

  def show_answer
    answer = convert_code_to_colors(secret_color_code)
    answer = color_to_colored_symbol(answer)
    puts '+--------------•--------------+'.color_it('bright_green')
    print '|  '.color_it('bright_green')
    answer.each { |color| print "   #{color}  " }
    puts '   |'.color_it('bright_green')
    puts '+--------------•--------------+'.color_it('bright_green')
  end
end