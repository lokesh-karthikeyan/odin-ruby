# frozen_string_literal: true

require_relative 'computer_makes_guess/print_guess'
require_relative 'colored_text'

# This Class contains method which would show the correct answer if the player is lost.
class PrintAnswer
  class << self
    using ColoredText

    def show(secret_code)
      answer = PrintGuess.new(secret_code).guessed_code
      puts '+--------------•--------------+'.color_it('bright_green')
      print '|  '.color_it('bright_green')
      answer.each { |colored_icon| print "   #{colored_icon}  " }
      puts '   |'.color_it('bright_green')
      puts '+--------------•--------------+'.color_it('bright_green')
    end
  end
end
