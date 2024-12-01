# frozen_string_literal: true

# This Class sorts an array with "Merge Sort" method.
class MergeSort
  def sort(array)
    return array if array.length.eql?(1) || array.empty?

    middle = array.length / 2

    left_array = sort(array[0...middle])
    right_array = sort(array[middle..])
    merge(left_array, right_array)
  end

  def merge(left_array, right_array)
    return right_array if left_array.empty?
    return left_array if right_array.empty?
    return [left_array.first] + merge(left_array[1..], right_array) if left_array.first <= right_array.first

    [right_array.first] + merge(left_array, right_array[1..]) if left_array.first > right_array.first
  end
end

puts MergeSort.new.sort([3, 2, 1, 13, 8, 5, 0, 1]).inspect
puts MergeSort.new.sort([105, 79, 100, 110]).inspect
puts MergeSort.new.sort([5, 10, 1, 3, 1, 11, 3, 7]).inspect
puts MergeSort.new.sort(Array.new(15) { rand(1..1000) }).inspect
