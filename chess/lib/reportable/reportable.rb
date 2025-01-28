# frozen_string_literal: true

require_relative '../colorable/colorable'

# Contains messages that can be printed inside the terminal.
module Reportable
  using Colorable

  def print_game_title
    title = <<~TITLE

       ██████╗██╗  ██╗███████╗███████╗███████╗
      ██╔════╝██║  ██║██╔════╝██╔════╝██╔════╝
      ██║     ███████║█████╗  ███████╗███████╗
      ██║     ██╔══██║██╔══╝  ╚════██║╚════██║
      ╚██████╗██║  ██║███████╗███████║███████║
       ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

    TITLE
    puts title.color_fg(:yellow)
  end

  def print_game_rules
    rules = <<~RULES
      In order to play this game, you need to enter the co-ordinates of the spot. #{'[Example: "a3", "F6"]'.color_fg(:light_red)}
      #{source_and_destination_rule}
      #{'  '}
      #{"Enough talk. Let's PLAY!!! ♚ ".color_fg(:blue).color_bg(:black)}
    RULES
    puts rules.color_fg(:light_cyan)
  end

  def source_and_destination_rule
    'The '.color_fg(:light_cyan) + 'SOURCE'.color_fg(:green) + ' and '.color_fg(:light_cyan) +
      'DESTINATION'.color_fg(:light_red) + ' must be entered separately in two different prompts.'.color_fg(:light_cyan)
  end

  def print_check_message
    check = <<~CHECK
      The King is in Check!
    CHECK
    puts check.color_fg(:red)
  end

  def print_check_mate_message(winner)
    check_mate = <<~MATE
      The King is in Check mate!!!
      #{winner.color_fg(:blue)} #{'has WON the game!'.color_fg(:green)}
    MATE
    puts check_mate.color_fg(:red)
  end

  def print_stale_mate_message
    stale_mate = <<~STALE_MATE
      No legal moves available!
      It's a #{'TIE'.color_fg(:yellow)} #{'by Stale mate!!'.color_fg(:orange)}
    STALE_MATE
    puts stale_mate.color_fg(:orange)
  end

  def print_three_fold_repetition_message
    three_fold_repetition = <<~THREE_FOLD_REPETITION
      Detected identical game state for three times!
      It's a #{'TIE'.color_fg(:yellow)} #{'by Three-Fold Repetition!!'.color_fg(:orange)}
    THREE_FOLD_REPETITION
    puts three_fold_repetition.color_fg(:orange)
  end

  def print_fifty_move_rule_message
    fifty_move_rule = <<~FIFTY_MOVE_RULE
      No Pawn movements (or) enemy captures detected for the last 50 moves!
      It's a #{'TIE'.color_fg(:yellow)} #{'by Fifty-Move rule!!'.color_fg(:orange)}
    FIFTY_MOVE_RULE
    puts fifty_move_rule.color_fg(:orange)
  end

  def print_file_saved_message
    file_saved = <<~FILE_SAVED
      The Game has been successfully saved!
      #{'Good bye!!'.color_fg(:orange)}
    FILE_SAVED
    puts file_saved.color_fg(:green)
  end

  def print_exit_message(active_player, inactive_player)
    exit_message = <<~EXIT_MESSAGE
      #{'The Game was won by'.color_fg(:green)} #{inactive_player.color_fg(:blue)} \
      #{'due to'.color_fg(:green)} #{active_player.color_fg(:blue)} #{'just quitting the game!'.color_fg(:green)}
    EXIT_MESSAGE
    puts exit_message
  end
end
