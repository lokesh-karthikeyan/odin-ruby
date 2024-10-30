# frozen_string_literal: true

require_relative 'colored_text'

# This Module contains methods that can be used to show the logs.
# Logs such as guess history & its corresponding feedback history at the end of the round.
module BeautifyLogs
  using ColoredText

  def show_log
    print_log_title
    print_log_content
  end

  def print_log_title
    divider_for_log_ui
    print '|   COUNT   |'.color_it('steel_blue')
    print '|          GUESS          |'.color_it('steel_blue')
    puts '|      SCORE      |'.color_it('steel_blue')
    divider_for_log_ui
  end

  def divider_for_log_ui
    puts '+-----------••-------------------------••-----------------+'.color_it('steel_blue')
  end

  def print_log_content
    feedback_history.length.times do |number|
      print '|'.color_it('steel_blue')
      print_number(number)
      print '||  '.color_it('steel_blue')
      print_guess(number)
      print_feedback(number)
    end
    divider_for_log_ui
  end

  def print_number(number)
    case number + 1
    when number + 1 < 9 then print "     #{number + 1}     ".color_it('steel_blue')
    when number + 1 > 9 then print "     #{number + 1}    ".color_it('steel_blue')
    end
  end

  def print_guess(index1)
    guess_history.first.length.times do |index2|
      print "   #{guess_history[index1][index2]}  "
    end
    print '   ||'.color_it('steel_blue')
  end

  def print_feedback(index1)
    feedback_history.first.length.times do |index2|
      print "  #{feedback_history[index1][index2]} "
    end
    puts ' |'.color_it('steel_blue')
  end
end
