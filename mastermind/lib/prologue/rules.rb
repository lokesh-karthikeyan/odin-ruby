# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class contains methods that prints the rules for an encoder & decoder.
class Rules
  using ColoredText

  class << self
    def rules_to_decoder
      print "Can you guess the right color combination within #{'12'.color_it('red')}".color_it('light_cyan')
      puts ' moves?'.color_it('light_cyan')
      puts ''
      notes
      puts ''
      example
      case_rule
      puts ''
    end

    def notes
      print 'NOTE: '.color_it('red')
      print "Each color in a guess should be separated by a #{'COMMA(,)'.color_it('steel_blue')}".color_it('light_cyan')
      puts '.'.color_it('light_cyan')
    end

    def example
      print "For exmaple:- #{'Red, Green, Blue, Purple'.color_it('red')}".color_it('light_cyan')
      print " or #{'YELLOW,PURPLE,BLUE,BLUE'.color_it('red')}".color_it('light_cyan')
      puts '.'.color_it('light_cyan')
    end

    def case_rule
      print "You can either use #{'UPCASE'.color_it('steel_blue')}".color_it('light_cyan')
      print " or #{'downcase'.color_it('steel_blue')}".color_it('light_cyan')
      print " or #{'Capitalize'.color_it('steel_blue')}".color_it('light_cyan')
      puts '.'.color_it('light_cyan')
    end

    def rules_to_encoder
      puts 'Pick any color combination from the available colors.'.color_it('light_cyan')
      print "I'll guess the answer within #{'12'.color_it('red')}".color_it('light_cyan')
      puts ' moves.'.color_it('light_cyan')
      puts ''
    end
  end
end
