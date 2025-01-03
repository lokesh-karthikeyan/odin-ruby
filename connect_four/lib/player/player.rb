# frozen_string_literal: true

require_relative '../displayable/displayable'

# Information about the players.
class Player
  attr_accessor :player1, :player2

  private

  include Displayable

  def initialize = create_player_profiles

  def create_player_profiles
    Struct.new('PlayerProfile', :id, :name, :disc)

    id, name, disc = create_player1_profile
    self.player1 = Struct::PlayerProfile.new(id, name, disc)

    id, name, disc = create_player2_profile
    self.player2 = Struct::PlayerProfile.new(id, name, disc)
  end

  def create_player1_profile
    id = 1
    name = player_name_prompt(id)
    disc = player_disc_color_prompt(name)
    [id, name, disc]
  end

  def create_player2_profile
    id = 2
    name = player_name_prompt(id)
    disc = player1.disc == 'yellow' ? 'red' : 'yellow'
    [id, name, disc]
  end
end
