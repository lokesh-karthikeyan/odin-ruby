# frozen_string_literal: true

require_relative 'colored_text'

# This Module contains method to show the list of available colors with colorized text.
module AvailableColors
  using ColoredText

  def print_available_colors
    print 'The available colors are'.color_it('light_cyan')
    print " #{'GREEN'.color_it('green')} #{'RED'.color_it('red')}"
    print " #{'BLUE'.color_it('blue')} #{'PURPLE'.color_it('purple')}"
    print " #{'ORANGE'.color_it('orange')} #{'YELLOW'.color_it('yellow')}"
    puts '.'.color_it('light_cyan')
    puts ''
  end
end
