# frozen_string_literal: true

require_relative 'colored_text'

# This Module converts the name of the colors to icons & apply colors to it.
module ColorIcons
  using ColoredText

  def apply_colors
    {
      'green' => "\u{2B24}".color_it('green'),
      'red' => "\u{2B24}".color_it('red'),
      'blue' => "\u{2B24}".color_it('blue'),
      'purple' => "\u{2B24}".color_it('purple'),
      'orange' => "\u{2B24}".color_it('orange'),
      'yellow' => "\u{2B24}".color_it('yellow')
    }
  end
end
