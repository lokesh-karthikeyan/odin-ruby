# frozen_string_literal: true

# This Module is the extension for 'String' class (Monkey Pathcing).
# It's objective is to color the texts.
module Colorable
  COLORS = {
    green: '119;221;119',
    bright_green: '102;255;0',
    cyan: '0;255;255',
    light_cyan: '224;255;255',
    red: '255;71;101',
    steel_blue: '70;130;180',
    bright_yellow: '255;234;0'
  }.freeze

  refine String do
    def color(color_name)
      color_in_rgb = COLORS[color_name]
      "\e[38;2;#{color_in_rgb}m#{self}\e[0m"
    end
  end
end
