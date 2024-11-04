# frozen_string_literal: true

require_relative 'colored_text'

# This Class has methods to announce the loser of the current round.
class PrintLoser
  class << self
    using ColoredText

    def player(guess)
      puts ''
      puts "You've lost! All #{guess - 1} guesses have been used.".color_it('red')
      puts ''
    end

    def computer
      puts ''
      puts 'An ERROR occurred! Please check if the provided feedbacks are correct!!'.color_it('red')
      puts ''
    end
  end
end
