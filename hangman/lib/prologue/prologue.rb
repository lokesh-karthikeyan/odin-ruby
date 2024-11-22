# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Class prints out the 'Introduction' of this game & it's rules.
class Prologue
  private

  using Colorable

  def print_game_title
    puts ''
    puts "╔╗ ╔╗
║║ ║║
║╚═╝║╔══╗ ╔═╗ ╔══╗╔╗╔╗╔══╗ ╔═╗
║╔═╗║╚ ╗║ ║╔╗╗║╔╗║║╚╝║╚ ╗║ ║╔╗╗
║║ ║║║╚╝╚╗║║║║║╚╝║║║║║║╚╝╚╗║║║║
╚╝ ╚╝╚═══╝╚╝╚╝╚═╗║╚╩╩╝╚═══╝╚╝╚╝
              ╔═╝║
              ╚══╝
    ".color(:bright_yellow)
  end

  def print_game_motto
    print "Find the correct word within #{'8'.color(:steel_blue)}".color(:green)
    puts " guesses and save a man's life!!!".color(:green)
    puts ''
  end

  def print_game_rules
    print "The letter can be either #{'A - Z'.color(:steel_blue)}".color(:light_cyan)
    puts " (or) #{'a - z'.color(:steel_blue)}".color(:light_cyan) + '.'.color(:light_cyan)

    print "You may enter only a #{'SINGLE'.color(:red)}".color(:light_cyan)
    puts " character. The only exception is #{'SAVE'.color(:green)}".color(:light_cyan) + ".\n".color(:light_cyan)
  end

  def print_save_game_rules
    print "If you want to save the current game, then type #{'save'.color(:green)}".color(:light_cyan)
    print ". It can either be in #{'UPCASE'.color(:steel_blue)}".color(:light_cyan)
    puts " (or) #{'downcase'.color(:steel_blue)}".color(:light_cyan) + ".\n".color(:light_cyan)
  end

  def print_notes_for_save_game
    print "#{'NOTE:'.color(:red)} By saving the game, you'll be ".color(:light_cyan)
    puts "#{'exited'.color(:red)} out of the current game.".color(:light_cyan)
  end

  public

  def commence
    print_game_title
    print_game_motto
    print_game_rules
    print_save_game_rules
    print_notes_for_save_game
  end
end
