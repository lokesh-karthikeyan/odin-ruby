# frozen_string_literal: true

# This class deals with player objects like player's name, player's flag and player's choice.
# These methods serves as a template to create player objects.
class Player
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

  def position_of_choice(player, player_banner)
    position = ''
    puts '                                                                                                           '
    puts '+ ------------------------------------------------------------------------------------------------------- +'
    loop do
      print "  #{player}, Enter the available placeholder number (1-9) to put the '#{player_banner}' in it's place: "
      position = gets.chomp.to_i
      puts '+ ------------------------------------------------------------------------------------------------------- +'
      break if position >= 1 && position <= 9
    end
    position
  end
end
