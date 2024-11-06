# frozen_string_literal: true

# Module handles Monkey-patching for the class 'String'.
# Any text can be colored by calling the 'refine' method by 'using' this module.
module ColoredText
  COLORS = {
    'green' => '119;221;119',
    'red' => '255;71;101',
    'blue' => '24;119;242',
    'purple' => '133;101;196',
    'orange' => '255;133;71',
    'yellow' => '255;225;71',
    'cyan' => '0;255;255',
    'steel_blue' => '70;130;180',
    'bright_green' => '102;255;0',
    'bright_yellow' => '255;234;0',
    'light_cyan' => '224;255;255'
  }.freeze

  refine String do
    def color_it(color)
      color_in_rgb = COLORS[color]
      "\e[38;2;#{color_in_rgb}m#{self}\e[0m"
    end
  end
end
