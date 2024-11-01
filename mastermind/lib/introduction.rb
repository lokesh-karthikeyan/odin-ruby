# frozen_string_literal: true

require_relative 'colored_text'

# This Module has methods about the introduction of this MasterMind game.
module Introduction
  using ColoredText

  def intro_and_roles(role1, role2)
    print "
▒█▀▄▀█ █▀▀█ █▀▀ ▀▀█▀▀ █▀▀ █▀▀█ █▀▄▀█ ░▀░ █▀▀▄ █▀▀▄
▒█▒█▒█ █▄▄█ ▀▀█ ░░█░░ █▀▀ █▄▄▀ █░▀░█ ▀█▀ █░░█ █░░█
▒█░░▒█ ▀░░▀ ▀▀▀ ░░▀░░ ▀▀▀ ▀░▀▀ ▀░░░▀ ▀▀▀ ▀░░▀ ▀▀▀░".color_it('bright_yellow')
    puts ''
    puts ''
    print "You're a #{role1.upcase.color_it('steel_blue')}".color_it('light_cyan')
    print " and I'm the #{role2.upcase.color_it('steel_blue')}".color_it('light_cyan')
    puts '.'.color_it('light_cyan')
  end
end
