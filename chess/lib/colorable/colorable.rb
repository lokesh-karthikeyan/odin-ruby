# frozen_string_literal: true

# String class extension to color the strings.
module Colorable
  COLORS = {
    orange: '203;96;21',
    black: '00;00;00',
    light_cyan: '224;255;255',
    light_red: '223;70;97',
    red: '255;0;0',
    green: '119;221;119',
    yellow: '255;234;0',
    cream: '254;251;234',
    hunter_green: '68;105;61',
    dark_green: '21;71;52',
    blue: '91;126;222'
  }.freeze

  refine String do
    def color_fg(color_name)
      rgb_color_code = COLORS[color_name]
      "\e[38;2;#{rgb_color_code}m#{self}\e[0m"
    end

    def color_bg(color_name)
      rgb_color_code = COLORS[color_name]
      "\e[48;2;#{rgb_color_code}m#{self}\e[0m"
    end
  end
end
