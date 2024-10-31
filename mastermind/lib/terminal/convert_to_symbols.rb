# frozen_string_literal: true

require_relative 'colored_text'

# This Module changes the scores & guesses to symbols.
# It also adds colors to these values.
module ConvertToSymbols
  using ColoredText

  def symbol_of_a_score
    {
      'B' => "\u{2714}".color_it('green'),
      'W' => "\u{25EF}".color_it('yellow'),
      'X' => "\u{1F5D9}".color_it('red')
    }
  end

  def symbol_of_a_color
    {
      'green' => '⬤'.color_it('green'),
      'red' => '⬤'.color_it('red'),
      'blue' => '⬤'.color_it('blue'),
      'purple' => '⬤'.color_it('purple'),
      'orange' => '⬤'.color_it('orange'),
      'yellow' => '⬤'.color_it('yellow')
    }
  end

  def score_to_colored_symbols(score)
    score = score.chars
    score.map! { |peg| symbol_of_a_score[peg] }
    score
  end

  def color_to_colored_symbol(colors_list)
    colors_list.map! { |color| symbol_of_a_color[color] }
    colors_list
  end

  def colors
    {
      green: 'GREEN'.color_it('green'),
      red: 'RED'.color_it('red'),
      blue: 'BLUE'.color_it('blue'),
      purple: 'PURPLE'.color_it('purple'),
      orange: 'ORANGE'.color_it('orange'),
      yellow: 'YELLOW'.color_it('yellow')
    }
  end
end
