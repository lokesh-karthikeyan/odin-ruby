# frozen_string_literal: true

require_relative '../terminal_ui/score_icons'
require_relative '../terminal_ui/colored_text'

# This Class explains the meaning of each score (or) feedback icon.
class FeedbackIndicator
  private

  using ColoredText
  def initialize
    @sample_score = ScoreIcons.new('BWXX').score
    @tick = @sample_score.first
    @circle = @sample_score[1]
    @cancel = @sample_score.last
    show_feedback_indications
  end

  def show_feedback_indications
    puts 'After each guess, the score will be computed & displayed as following icons.'.color_it('light_cyan')
    puts ''
    border
    print_row1
    print_row2
    print_row3
    puts ''
  end

  def border
    puts '+---•---------------------------------------+'.color_it('steel_blue')
  end

  def separator
    '|'.color_it('steel_blue')
  end

  def print_row1
    print separator
    print " #{@tick} "
    print "→ Indicates #{'properly placed'.color_it('green')}".color_it('light_cyan')
    print ' colors.     '.color_it('light_cyan')
    puts separator
    border
  end

  def print_row2
    print separator
    print " #{@circle} "
    print "→ Indicates #{'misplaced'.color_it('yellow')}".color_it('light_cyan')
    print ' colors.           '.color_it('light_cyan')
    puts separator
    border
  end

  def print_row3
    print separator
    print " #{@cancel} "
    print "→ Indicates #{'invalid'.color_it('red')}".color_it('light_cyan')
    print ' colors.             '.color_it('light_cyan')
    puts separator
    border
  end
end
