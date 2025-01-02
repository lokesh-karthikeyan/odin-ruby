# frozen_string_literal: true

# Functionalities to check if the given array has 4 connected discs.
# Those discs must be either aligned by horizontal (or) vertical (or) diagonal.
class ConditionsToWin
  def conditions_satisfied?(matrix_array, indices, player_id)
    self.matrix_array = matrix_array
    self.indices = indices
    self.player_id = player_id

    horizontal_connection? || vertical_connection? || leading_diagonal_connection? || trailing_diagonal_connection?
  end

  def horizontal_connection?(row = indices.first, column = indices.last, current_disc_count = 1)
    accept_decrementation(column: true)
    left_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    accept_incrementation(column: true)
    right_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    total_discs = left_discs_count + current_disc_count + right_discs_count
    discs_connected?(total_discs)
  end

  def vertical_connection?(row = indices.first, column = indices.last, current_disc_count = 1)
    accept_decrementation(row: true)
    top_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    accept_incrementation(row: true)
    bottom_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    total_discs = top_discs_count + current_disc_count + bottom_discs_count
    discs_connected?(total_discs)
  end

  def leading_diagonal_connection?(row = indices.first, column = indices.last, current_disc_count = 1)
    accept_decrementation(row: true, column: true)
    upward_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    accept_incrementation(row: true, column: true)
    downward_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    total_discs = upward_discs_count + current_disc_count + downward_discs_count
    discs_connected?(total_discs)
  end

  def trailing_diagonal_connection?(row = indices.first, column = indices.last, current_disc_count = 1)
    accept_incrementation(column: true)
    accept_decrementation(row: true)
    upward_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    accept_incrementation(row: true)
    accept_decrementation(column: true)
    downward_discs_count = count_next_discs(row, column)
    deny_incrementation_and_decrementation

    total_discs = upward_discs_count + current_disc_count + downward_discs_count
    discs_connected?(total_discs)
  end

  def count_next_discs(row, column, total_discs = 0)
    CONNECTED_DISCS.times do
      row = row_scaling(row)
      column = column_scaling(column)
      total_discs += 1 if identical_discs?(row, column)
      return total_discs if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
  end

  private

  CONNECTED_DISCS = 4

  attr_accessor :matrix_array, :indices, :player_id

  def initialize = deny_incrementation_and_decrementation

  def accept_incrementation(row: false, column: false)
    @has_to_increment_row = true if row
    @has_to_increment_column = true if column
  end

  def accept_decrementation(row: false, column: false)
    @has_to_decrement_row = true if row
    @has_to_decrement_column = true if column
  end

  def deny_incrementation_and_decrementation
    @has_to_increment_row = false
    @has_to_decrement_row = false
    @has_to_increment_column = false
    @has_to_decrement_column = false
  end

  def increment_row? = @has_to_increment_row

  def decrement_row? = @has_to_decrement_row

  def increment_column? = @has_to_increment_column

  def decrement_column? = @has_to_decrement_column

  def row_scaling(row_index)
    row_index += 1 if increment_row?
    row_index -= 1 if decrement_row?
    row_index
  end

  def column_scaling(column_index)
    column_index += 1 if increment_column?
    column_index -= 1 if decrement_column?
    column_index
  end

  def discs_connected?(total_discs) = (total_discs == CONNECTED_DISCS)

  def identical_discs?(row_index, column_index) = matrix_array.dig(row_index, column_index) == player_id
end
