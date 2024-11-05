# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class has methods to announce the winner of the current round.
class PrintWinner
  class << self
    using ColoredText

    def player(guess)
      puts ''
      puts "Awesome! You've won in #{guess - 1} guesses.".color_it('green')
      puts ''
    end

    def computer(guess)
      puts ''
      puts "Easy Peasy! I've won in just #{guess - 1} guesses.".color_it('green')
      puts ''
    end
  end
end
