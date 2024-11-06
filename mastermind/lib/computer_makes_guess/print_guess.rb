# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'
require_relative '../terminal_ui/color_codes'
require_relative '../terminal_ui/color_icons'

# This Class gets the guess(numeric) & converts to color names.
# It then applies colors to the color icons with appropriate color.
class PrintGuess
  private

  include ColorCodes
  include ColorIcons
  using ColoredText

  def initialize(guessed_code)
    @guessed_code = guessed_code.chars
    to_color_name
    to_colored_icons
  end

  def to_color_name
    @guessed_code.map! { |code| color_of_a_code.key(code) }
  end

  def to_colored_icons
    @guessed_code.map! { |color_name| apply_colors[color_name] }
  end

  public

  attr_reader :guessed_code

  def my_guess(guess, max_guess)
    puts "My guess (#{guess}/#{max_guess}) is:- ".color_it('light_cyan')
    puts ''
    puts '+--------------•--------------+'.color_it('cyan')
    print '|  '.color_it('cyan')
    @guessed_code.each { |colored_icon| print "   #{colored_icon}  " }
    puts '   |'.color_it('cyan')
    puts '+--------------•--------------+'.color_it('cyan')
    puts ''
  end
end
