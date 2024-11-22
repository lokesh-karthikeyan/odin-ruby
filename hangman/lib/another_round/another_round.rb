# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Class asks the player if the game can be continued after the end of the each round.
class AnotherRound
  using Colorable

  class << self
    def play?
      enquire_choice

      choice = enter_choice
      choice.eql?('y') ? true : false
    end

    private

    def enquire_choice
      puts ''
      puts 'Do you wanna play another round?'.color(:cyan)
      print "Press 'Y' for #{'YES'.color(:green)}".color(:cyan)
      puts " (or) 'N' for #{'NO'.color(:red)}".color(:cyan) + '.'.color(:cyan)
    end

    def enter_choice
      puts ''
      print 'Enter your choice (y/n): '.color(:light_cyan)
      choice = gets.chomp.downcase
      choice = print_invalid_choice until %w[y n].include?(choice)
      choice
    end

    def print_invalid_choice
      puts ''
      puts 'Invalid choice!!!. Enter "y" (or) "n".'.color(:red)
      enter_choice
    end
  end
end
