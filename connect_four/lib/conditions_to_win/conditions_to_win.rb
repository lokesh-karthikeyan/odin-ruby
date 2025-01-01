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
    total_discs = 1
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      column += 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    column = indices.last
    CONNECTED_DISCS.times do
      column -= 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    discs_connected?(total_discs)
  end

  def vertical_connection?
    total_discs = 1
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      row += 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    row = indices.first
    CONNECTED_DISCS.times do
      row -= 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    discs_connected?(total_discs)
  end

  def leading_diagonal_connection?
    total_discs = 1
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      row += 1
      column += 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    row = indices.first
    column = indices.last
    CONNECTED_DISCS.times do
      row -= 1
      column -= 1
      total_discs += 1 if identical_discs?(row, column)
      break if !identical_discs?(row, column) || discs_connected?(total_discs)
    end
    discs_connected?(total_discs)
  end

  private

  CONNECTED_DISCS = 4

  attr_accessor :matrix_array, :indices, :player_id

  def discs_connected?(total_discs) = (total_discs == CONNECTED_DISCS)

  def identical_discs?(row_index, column_index) = matrix_array.dig(row_index, column_index) == player_id
end
