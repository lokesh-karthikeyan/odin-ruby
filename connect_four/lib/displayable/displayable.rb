# frozen_string_literal: true

require_relative '../colorable/colorable'

# Components / Functionalities related to terminal output.
module Displayable
  using Colorable

  def player_name_prompt(player_id) = print "\nEnter the name of the Player-#{player_id}: ".color(:light_cyan)

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
end
