# frozen_string_literal: true

require_relative 'print_play_next_round'
require_relative 'print_next_round_roles'

# This Class acts like a central class where it calls other class's methods.
# It identifies whether the player wants to play next round, if so, then the role the player wants.
class PlayAnotherRound
  private

  using ColoredText

  def initialize
    @choice = ''
    enquire_to_play_next_round
  end

  def enquire_to_play_next_round
    response = PrintPlayNextRound.new
    @choice = response.print_play_next_round
    @choice = 0 if @choice == 'n'
    enquire_roles if @choice == 'y'
  end

  def enquire_roles
    roles = PrintNextRoundRoles.new
    option = roles.print_enquire_roles
    @choice = 1 if option == '1'
    @choice = 2 if option == '2'
  end

  public

  attr_reader :choice
end
