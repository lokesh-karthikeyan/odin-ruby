# frozen_string_literal: true

# String class extension to color the strings.
module Colorable
  COLORS = {
    blue: '24;119;242',
    bright_red: '255;0;0',
    green: '119;221;119',
    light_cyan: '224;255;255',
    purple: '133;101;196',
    red: '255;71;101',
    yellow: '255;234;0'
  }.freeze

  refine String do
    def color(color_name)
      color_in_rgb = COLORS[color_name]
      "\e[38;2;#{color_in_rgb}m#{self}\e[0m"
    end
  end
end
