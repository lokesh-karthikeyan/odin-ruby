# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class asks the player whether he / she wants to play another round.
class PrintPlayNextRound
  private

  using ColoredText
  def enquire_next_round
    puts 'Do you want to play another round?'.color_it('light_cyan')
    puts ''
  end

  def print_yes
    print "Press #{'y'.color_it('green')}".color_it('cyan')
    print " → #{'[Y]es'.color_it('steel_blue')}".color_it('cyan')
    print ' (or) '.color_it('cyan')
  end

  def print_no
    print "Press #{'n'.color_it('red')}".color_it('cyan')
    print " → #{'[N]o'.color_it('steel_blue')}".color_it('cyan')
    puts '.'.color_it('cyan')
  end

  def enter_choice
    print 'Enter your choice (y/n) : '.color_it('light_cyan')
    gets.chomp
  end

  def print_invalid_response
    puts 'Invalid response!! Please enter the valid response (y/n).'.color_it('red')
    puts ''
    enter_choice
  end

  def valid_input?(response)
    %w[y Y n N].include?(response)
  end

  public

  def print_play_next_round
    enquire_next_round
    print_yes
    print_no
    puts ''
    choice = enter_choice
    choice = print_invalid_response until valid_input?(choice)
    choice.downcase
  end
end
