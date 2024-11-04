# frozen_string_literal: true

require_relative 'print_winner'
require_relative 'print_loser'
require_relative 'print_logs'
require_relative 'print_answer'
require_relative 'colored_text'

# This Class acts like a central class where it creates instances of different classes.
# Depending whether the player (or) computer has won (or) lost.
class GameOver
  using ColoredText

  def initialize(count)
    @count = count
  end

  def player_won(guess_log, score_log)
    PrintWinner.player(@count)
    PrintLogs.new(guess_log, score_log)
  end

  def player_lost(secret_code, guess_log, score_log)
    PrintLoser.player(@count)
    PrintLogs.new(guess_log, score_log)
    puts ''
    puts 'The right combination is:- '.color_it('bright_green')
    puts ''
    PrintAnswer.show(secret_code)
  end

  def computer_won(guess_log, score_log)
    PrintWinner.computer(@count)
    PrintLogs.new(guess_log, score_log)
  end

  def error_occured
    PrintLoser.computer
  end
end
