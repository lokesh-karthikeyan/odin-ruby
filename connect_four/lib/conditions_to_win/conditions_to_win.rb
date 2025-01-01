# frozen_string_literal: true

# Functionalities to check if the given array has 4 connected discs.
# Those discs must be either aligned by horizontal (or) vertical (or) diagonal.
class ConditionsToWin
  def conditions_satisfied?(matrix_array, indices, player_id)
    self.matrix_array = matrix_array
    self.indices = indices
    self.player_id = player_id
    horizontal_connection?
  end

  def horizontal_connection?
    discs_count = 1
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      column += 1
      discs_count += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(discs_count)
    end
    column = indices.last
    CONNECTED_DISCS.times do
      column -= 1
      discs_count += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(discs_count)
    end
    discs_connected?(discs_count)
  end

  def vertical_connection?
    discs_count = 1
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      row += 1
      discs_count += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(discs_count) || last_row?(row)
    end
    row = indices.first
    CONNECTED_DISCS.times do
      row -= 1
      discs_count += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(discs_count) || last_row?(row)
    end
    discs_connected?(discs_count)
  end

  private

  CONNECTED_DISCS = 4

  attr_accessor :matrix_array, :indices, :player_id

  def discs_connected?(discs_count) = (discs_count == CONNECTED_DISCS)

  def identical_discs?(row_index, column_index) = matrix_array[row_index][column_index] == player_id

  def last_row?(row_index) = (row_index == (matrix_array.length - 1))
end
