# frozen_string_literal: true

# This class deals with player objects like player's name, player's flag and player's choice.
# These methods serves as a template to create player objects. It also contains class instance variables and methods.
class Player
  @available_positions = (1..9).to_a

  class << self
    attr_accessor :available_positions
  end

  def self.valid_position?(position)
    return false unless available_positions.include?(position)

    available_positions.delete(position)
    true
  end

  def name(number)
    puts '                                                                                                           '
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    print "  Enter the name of the 'Player-#{number}': "
    player_name = gets.chomp
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    player_name
  end

  def banner(player)
    selection = ''
    puts '                                                                                                           '
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    loop do
      print "  #{player}, Select either 'X -> Cross' (or) 'O -> Nought': "
      selection = gets.chomp.upcase
      puts '+ ------------------------------------------------------------------------------------------------------- +'
      break if %w[X O].include?(selection)
    end
    selection
  end

  def valid_position?(number)
    return false unless valid_positions.include?(number)

    valid_positions.delete(number)
    true
  end

  def position_of_choice(player, player_banner)
    position = ''
    puts '                                                                                                           '
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    loop do
      print "  #{player}, Enter the available placeholder number (1-9) to put the '#{player_banner}' in it's place: "
      position = gets.chomp.to_i
      puts '+ ------------------------------------------------------------------------------------------------------- +'
      break if self.class.valid_position?(position)
    end
    position
  end
end
