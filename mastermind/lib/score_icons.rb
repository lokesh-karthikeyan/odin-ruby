# frozen_string_literal: true

require_relative 'colored_text'

# This Class converts the score to colored icons as a key/value pair.
class ScoreIcons
  using ColoredText

  attr_reader :score

  def initialize(score)
    @score = score.chars
    replace_colored_icons
  end

  def score_icons
    {
      'B' => "\u{2714}".color_it('green'),
      'W' => "\u{25EF}".color_it('yellow'),
      'X' => "\u{1F5D9}".color_it('red')
    }
  end

  def replace_colored_icons
    @score.map! { |character| score_icons[character] }
    @score
  end
end
