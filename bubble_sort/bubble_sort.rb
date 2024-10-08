def bubble_sort(array)
  is_modified = nil
  temporary_value = nil
  length = array.length - 1
  sort_length = array.length - 1

  length.times do
    sort_length.times do |number|
      if array[number] > array[number + 1]
        temporary_value = array[number]
        array[number] = array[number + 1]
        array[number + 1] = temporary_value
        is_modified = true
      else
        is_modified = false
        next
      end
    end
    sort_length -= 1
    break if is_modified == false
  end
  array
end

bubble_sort([4, 3, 78, 2, 0, 2])
