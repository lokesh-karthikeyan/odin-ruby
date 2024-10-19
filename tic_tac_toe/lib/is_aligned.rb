# frozen_string_literal: true

# This Module contains a bunch of methods where it returns boolean value.
# For exmaple, any of the rows (or) columns (or) diagonals equal? Each row (or) column check is in separate method.
module IsAligned
  def blank_space?(value)
    value.eql?(' ')
  end

  def row1_equal?
    return false if blank_space?(options[1])

    options[1] == options[2] && options[1] == options[3]
  end

  def row2_equal?
    return false if blank_space?(options[4])

    options[4] == options[5] && options[4] == options[6]
  end

  def row3_equal?
    return false if blank_space?(options[7])

    options[7] == options[8] && options[7] == options[9]
  end

  def column1_equal?
    return false if blank_space?(options[1])

    options[1] == options[4] && options[1] == options[7]
  end

  def column2_equal?
    return false if blank_space?(options[2])

    options[2] == options[5] && options[2] == options[8]
  end

  def column3_equal?
    return false if blank_space?(options[3])

    options[3] == options[6] && options[3] == options[9]
  end

  def left_diagonal_equal?
    return false if blank_space?(options[5])

    options[1] == options[5] && options[1] == options[9]
  end

  def right_diagonal_equal?
    return false if blank_space?(options[5])

    options[3] == options[5] && options[3] == options[7]
  end

  def any_of_the_rows_equal?
    row1_equal? || row2_equal? || row3_equal?
  end

  def any_of_the_columns_equal?
    column1_equal? || column2_equal? || column3_equal?
  end

  def any_of_the_diagonals_equal?
    left_diagonal_equal? || right_diagonal_equal?
  end

  def won?(number)
    return false if number < 5

    any_of_the_rows_equal? || any_of_the_columns_equal? || any_of_the_diagonals_equal?
  end
end
