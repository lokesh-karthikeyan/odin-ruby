# frozen_string_literal: true

# This Module contains the creation of 'Linked List' Data structure.
# It also contains linked list related operations.
module LinkedList
  private

  # This Class creates an instance of nodes.
  # It contains 'Key', 'Value' and pointer to the 'Next node'.
  class Node
    def initialize(key = nil, value = nil, next_node = nil)
      self.key = key
      self.value = value
      self.next_node = next_node
    end

    attr_accessor :key, :value, :next_node
  end

  def create_node(key = nil, value = nil, next_node = nil) = Node.new(key, value, next_node)

  def append_first_node(index, key, value)
    new_node = create_node(key, value)
    bucket[index] = new_node
    tail[index] = new_node
    increase_length
  end

  def append_node(index, key, value)
    new_node = create_node(key, value)
    tail[index].next_node = new_node
    tail[index] = new_node
    increase_length
  end

  def replace_node_value(index, key, value)
    current_node = bucket[index]

    while current_node
      return current_node.value = value if current_node.key == key

      current_node = current_node.next_node
    end
  end

  public

  def add(index, key, value)
    return append_first_node(index, key, value) if bucket[index].nil?
    return replace_node_value(index, key, value) if has?(key)

    append_node(index, key, value)
  end

  def delete_first_node(index)
    value = bucket[index].value

    bucket[index] = nil
    decrease_length
    value
  end

  def delete_node(index, key)
    current_node = bucket[index]

    current_node = current_node.next_node until current_node.next_node.key == key
    value = current_node.next_node.value
    current_node.next_node = current_node.next_node.next_node
    decrease_length
    value
  end
end
