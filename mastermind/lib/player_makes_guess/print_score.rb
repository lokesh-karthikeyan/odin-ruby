# frozen_string_literal: true

require_relative '../terminal_ui/colored_text'

# This Class prints out the feedback / score of entered guess.
class PrintScore
  class << self
    using ColoredText

    def show(score)
      puts ''
      puts '+----------•----------+'.color_it('cyan')
      print '|'.color_it('cyan')
      score.each { |score_icon| print "  #{score_icon}  " }
      puts ' |'.color_it('cyan')
      puts '+----------•----------+'.color_it('cyan')
      puts ''
    end
  end
end
