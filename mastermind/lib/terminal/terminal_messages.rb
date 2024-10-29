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

  def make_computer_to_guess; end
end
