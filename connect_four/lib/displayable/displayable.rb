# frozen_string_literal: true

require_relative '../colorable/colorable'

# Components / Functionalities related to terminal output.
module Displayable
  using Colorable

  def print_game_title
    introduction = <<~TITLE

       ▗▄▄▖▄▄▄  ▄▄▄▄  ▄▄▄▄  ▗▞▀▚▖▗▞▀▘   ■      ▗▄▄▄▖ ▄▄▄  █  ▐▌ ▄▄▄
      ▐▌  █   █ █   █ █   █ ▐▛▀▀▘▝▚▄▖▗▄▟▙▄▖    ▐▌   █   █ ▀▄▄▞▘█
      ▐▌  ▀▄▄▄▀ █   █ █   █ ▝▚▄▄▖      ▐▌      ▐▛▀▀▘▀▄▄▄▀      █
      ▝▚▄▄▖                            ▐▌      ▐▌
                                       ▐▌

    TITLE
    puts introduction.color(:purple)
  end

  def print_game_information
    puts "Welcome! Choose one of the discs [#{yellow_disc}".color(:light_cyan) +
         " ] (or) [#{red_disc}".color(:light_cyan) +
         ' ] and place them in the board.'.color(:light_cyan)
    puts "The player who aligns 4 consecutive discs wins the match.\n".color(:light_cyan)
  end

  def print_board(game_board, player_disc_id)
    print_column_headers
    print_board_borders
    game_board.each do |row|
      print '    |'.color(:light_cyan)
      row.each { |disc| print_disc(disc, player_disc_id) }
      puts ''
      print_board_borders
    end
    print_board_footer
  end

  def print_game_rules
    puts "\nYou can align in either horizontal, vertical (or) diagonal.\n".color(:light_cyan)
    puts "Enough talk. Let's PLAY!!! 🎲".color(:green)
  end

  def player_name_prompt(player_id)
    print "\nEnter the name of the Player-#{player_id}".color(:light_cyan) + ': '.color(:light_cyan)
  end

  def print_available_disc_colors
    puts "\nPress either '1' -> [#{yellow_disc}".color(:blue) +
         " ] (or) '2' -> [#{red_disc}".color(:blue) +
         ' ].'.color(:blue)
  end

  def player_disc_color_prompt(name) = print "#{name}, Enter your choice(1/2): ".color(:light_cyan)

  def empty_disc = "\u{25EF}".color(:blue)

  def yellow_disc = "\u{2B24}".color(:yellow)

  def red_disc = "\u{2B24}".color(:red)

  def print_invalid_selection = puts "Invalid Selection.\n".color(:bright_red)

  def print_column_headers
    puts '    ____________________________________'.color(:orange)
    puts "    | \u{1D7D9}  | \u{1D7DA}  | \u{1D7DB}  | \u{1D7DC}  |".color(:orange) +
         " \u{1D7DD}  | \u{1D7DE}  | \u{1D7DF}  |".color(:orange)
    puts '    ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'.color(:orange)
  end

  def print_board_borders = puts '    +-••-+-••-+-••-+-••-+-••-+-••-+-••-+'

  def print_disc(disc, player_disc_id)
    if player_disc_id[disc].nil?
      print " #{empty_disc} " + ' |'.color(:light_cyan)
    elsif player_disc_id[disc] == 'yellow'
      print " #{yellow_disc} " + ' |'.color(:light_cyan)
    else
      print " #{red_disc} " + ' |'.color(:light_cyan)
    end
  end

  def print_board_footer
    puts '   /                                    \\'.color(:orange)
    puts ' =========================================='.color(:orange)
  end
end
