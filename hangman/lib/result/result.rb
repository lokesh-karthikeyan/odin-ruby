# frozen_string_literal: true

require_relative '../colorable/colorable'
require_relative 'hangman_figurine'

# This Class prints the result of an each guess and also an entire round.
class Result
  using Colorable

  class << self
    include HangmanFigurine

    def correct_guess(choice)
      puts ''
      print "You got it right. #{choice.upcase.color(:steel_blue)}".color(:green)
      puts ' is in the secret word.'.color(:green)
    end

    def incorrect_guess(lives)
      puts ''
      puts 'Oops! Incorrect guess.'.color(:red)
      puts "You've got only #{lives.color(:green)}".color(:red) + ' chance(s) left.'.color(:red) unless lives.eql?('0')
      print_figurine(lives)
    end

    def won
      puts ''
      print "Hurray! You've won!! The #{'"Mystery Word"'.color(:bright_yellow)}".color(:green)
      puts ' has been unveiled.'.color(:green)
    end

    def lost
      puts ''
      puts "You've lost! You've used up all the chances!!\n".color(:red)
      puts 'Cheer up! You can try again!!.'.color(:cyan)
    end
  end
end
