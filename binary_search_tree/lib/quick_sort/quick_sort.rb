# frozen_string_literal: true

# This Class sorts the given array by 'Quick Sort' method.
class QuickSort
  attr_accessor :sorted_array

  private

  attr_accessor :unsorted_array

  def initialize(array)
    self.unsorted_array = array
    self.sorted_array = sort(unsorted_array)
  end

  def sort(array)
    return [] if array.empty?

    pivot, *array = *array
    lesser_than_pivot, greater_than_pivot = array.partition { |element| element < pivot }

    sort(lesser_than_pivot) + [pivot] + sort(greater_than_pivot)
  end
end
