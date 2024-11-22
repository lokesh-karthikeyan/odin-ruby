# frozen_string_literal: true

require_relative '../colorable/colorable'

# This Module contains the hangman figurine of various designs.
module HangmanFigurine
  using Colorable

  def print_figurine(lives)
    method = "figurine#{lives}"
    send(method)
  end

  def figurine_header
    puts ''
    puts '      +------+'.color(:steel_blue)
    puts '      |      |'.color(:steel_blue)
  end

  def figurine_footer
    puts '   |‾‾‾‾‾|'.color(:cyan) + '   |'.color(:steel_blue)
    puts '  ==============='.color(:steel_blue)
  end

  def figurine_face
    puts '      O'.color(:green) + '      |'.color(:steel_blue)
  end

  def figurine_body_and_hands
    puts '     /|\\'.color(:green) + '     |'.color(:steel_blue)
  end

  def figurine_full_body(color = :green)
    puts '      O'.color(color) + '      |'.color(:steel_blue)
    puts '     /|\\'.color(color) + '     |'.color(:steel_blue)
    puts '     / \\'.color(color) + '     |'.color(:steel_blue)
  end

  def figurine7
    figurine_header
    puts '             |'.color(:steel_blue)
    puts '             |'.color(:steel_blue)
    puts '             |'.color(:steel_blue)
    figurine_footer
  end

  def figurine6
    figurine_header
    figurine_face
    puts '             |'.color(:steel_blue)
    puts '             |'.color(:steel_blue)
    figurine_footer
  end

  def figurine5
    figurine_header
    figurine_face
    puts '      |'.color(:green) + '      |'.color(:steel_blue)
    puts '             |'.color(:steel_blue)
    figurine_footer
  end

  def figurine4
    figurine_header
    figurine_face
    puts '     /|'.color(:green) + '      |'.color(:steel_blue)
    puts '             |'.color(:steel_blue)
    figurine_footer
  end

  def figurine3
    figurine_header
    figurine_face
    figurine_body_and_hands
    puts '             |'.color(:steel_blue)
    figurine_footer
  end

  def figurine2
    figurine_header
    figurine_face
    figurine_body_and_hands
    puts '     /'.color(:green) + '       |'.color(:steel_blue)
    figurine_footer
  end

  def figurine1
    figurine_header
    figurine_face
    figurine_body_and_hands
    puts '     / \\'.color(:green) + '     |'.color(:steel_blue)
    figurine_footer
  end

  def figurine0
    figurine_header
    figurine_full_body(:red)
    puts '             |'.color(:steel_blue)
    puts '  ==============='.color(:red)
  end
end
