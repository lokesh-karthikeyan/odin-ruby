# frozen_string_literal: true

require_relative '../displayable/displayable'

# Queries to ask players while profile creation.
module PlayerQueryable
  include Displayable

  def enquire_player1_details
    id = 1
    name = player_name(id)
    disc = player_marker(name)
    { id: id, name: name, disc_color: disc }
  end

  def enquire_player2_details(other_player_disc)
    id = 2
    name = player_name(id)
    disc = other_player_disc == 'yellow' ? 'red' : 'yellow'
    { id: id, name: name, disc_color: disc }
  end

  def player_name(id)
    player_name_prompt(id)
    gets.chomp
  end

  def player_marker(name, valid_disc_colors = %w[1 2])
    print_available_disc_colors
    disc = ''
    loop do
      player_disc_color_prompt(name)
      disc = gets.chomp

      break if valid_disc_colors.include?(disc)

      print_invalid_selection
    end
    disc == '1' ? 'yellow' : 'red'
  end
end
