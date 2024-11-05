# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class asks whether the player wants to be a "Code Breaker" (or) "Code Maker".
class PrintNextRoundRoles
  private

  using ColoredText

  def enquire_roles
    puts ''
    print "Do you want to be a #{'CODE BREAKER'.color_it('steel_blue')}".color_it('light_cyan')
    print " or a #{'CODE MAKER'.color_it('steel_blue')}".color_it('light_cyan')
    puts '?'.color_it('light_cyan')
    puts ''
  end

  def print_code_breaker
    print "Press #{'1'.color_it('bright_yellow')}".color_it('cyan')
    print " → #{'CODE BREAKER'.color_it('steel_blue')}".color_it('cyan')
    print ' (or) '.color_it('cyan')
  end

  def print_code_maker
    print "Press #{'2'.color_it('bright_yellow')}".color_it('cyan')
    print " → #{'CODE MAKER'.color_it('steel_blue')}".color_it('cyan')
    puts '.'.color_it('cyan')
  end

  def enter_choice
    print 'Enter your choice (1 or 2) : '.color_it('light_cyan')
    gets.chomp
  end

  def print_invalid_choice
    puts 'Invalid response!! Please enter the valid response (1 or 2).'.color_it('red')
    puts ''
    enter_choice
  end

  def valid_input?(response)
    %w[1 2].include?(response)
  end

  public

  def print_enquire_roles
    enquire_roles
    print_code_breaker
    print_code_maker
    puts ''
    option = enter_choice
    option = print_invalid_choice until valid_input?(option)
    option
  end
end
