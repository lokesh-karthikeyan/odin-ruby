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
      ─────────────X THE KING IS IN CHECK! X─────────────
    CHECK
    puts check.color_fg(:red)
  end

  def print_check_mate_message(winner)
    check_mate = <<~MATE

      #{border}
      #{'The King is in Check mate!!!'.color_fg(:red)}
      #{winner.color_fg(:blue)} #{'has WON the game!'.color_fg(:green)}
      #{border}

    MATE
    puts check_mate
  end

  def print_stale_mate_message
    stale_mate = <<~STALE_MATE

      #{border}
      #{'No legal moves available!'.color_fg(:orange)}
      #{"It's a".color_fg(:orange)} #{'TIE'.color_fg(:yellow)} #{'by Stale mate!!'.color_fg(:orange)}
      #{border}

    STALE_MATE
    puts stale_mate
  end

  def print_three_fold_repetition_message
    three_fold_repetition = <<~THREE_FOLD_REPETITION

      #{border}
      #{'Detected identical game state for three times!'.color_fg(:orange)}
      #{"It's a".color_fg(:orange)} #{'TIE'.color_fg(:yellow)} #{'by Three-Fold Repetition!!'.color_fg(:orange)}
      #{border}

    THREE_FOLD_REPETITION
    puts three_fold_repetition
  end

  def print_fifty_move_rule_message
    fifty_move_rule = <<~FIFTY_MOVE_RULE

      #{border}
      #{'No Pawn movements (or) enemy captures detected for the last 50 moves!'.color_fg(:orange)}
      #{"It's a".color_fg(:orange)} #{'TIE'.color_fg(:yellow)} #{'by Fifty-Move rule!!'.color_fg(:orange)}
      #{border}

    FIFTY_MOVE_RULE
    puts fifty_move_rule
  end

  def print_file_saved_message
    file_saved = <<~FILE_SAVED

      #{border}
      #{'The Game has been successfully saved!'.color_fg(:green)}
      #{'Good bye!!'.color_fg(:orange)}
      #{border}

    FILE_SAVED
    puts file_saved
  end

  def print_file_unsaved_message
    file_not_saved = <<~FILE_NOT_SAVED

      #{border}
      #{'No moves detected to save the game. File operations has been ABORTED!'.color_fg(:red)}
      #{'Good bye!!'.color_fg(:orange)}
      #{border}

    FILE_NOT_SAVED
    puts file_not_saved
  end

  def print_exit_message(active_player, inactive_player)
    exit_message = <<~EXIT_MESSAGE

      #{border}
      #{'The Game was won by'.color_fg(:green)} #{inactive_player.color_fg(:blue)} \
      #{'due to'.color_fg(:green)} #{active_player.color_fg(:blue)} #{'just quitting the game!'.color_fg(:green)}
      #{border}

    EXIT_MESSAGE
    puts exit_message
  end

  def border = '================================ • ✠ • ================================'.color_fg(:yellow)
end
