# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class has methods that handles printing the guesses & scores that took to win (or) lose.
class PrintLogs
  using ColoredText

  private

  def initialize(guess_history, score_history)
    @guess_history = guess_history
    @score_history = score_history
    guess_and_score_history
  end

  def guess_and_score_history
    table_header
    table_data
  end

  def table_header
    border
    print '|   COUNT   |'.color_it('steel_blue')
    print '|            GUESS            |'.color_it('steel_blue')
    puts '|      SCORE      |'.color_it('steel_blue')
    border
  end

  def border
    puts '+-----------••-----------------------------••-----------------+'.color_it('steel_blue')
  end

  def table_data
    @score_history.length.times do |number|
      print '|'.color_it('steel_blue')
      print_column1_count(number)
      print '||  '.color_it('steel_blue')
      print_column2_guess(number)
      print_column3_score(number)
    end
    border
  end

  def print_column1_count(count)
    if (count + 1) < 10
      print "     #{count + 1}     ".color_it('steel_blue')
    else
      print "     #{count + 1}    ".color_it('steel_blue')
    end
  end

  def print_column2_guess(index1)
    @guess_history.first.length.times do |index2|
      print "   #{@guess_history[index1][index2]}  "
    end
    print '   ||'.color_it('steel_blue')
  end

  def print_column3_score(index1)
    @score_history.first.length.times do |index2|
      print "  #{@score_history[index1][index2]} "
    end
    puts ' |'.color_it('steel_blue')
  end
end
