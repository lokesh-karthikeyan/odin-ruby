# frozen_string_literal: true

# This Module contains 'Node' Class for 'Hash Map'.
# It also has methods that are related to 'Hash Map'.
module MapOperations
  private

  # This Class creates 'Node' data structure for 'Hash Map'.
  class Node
    attr_accessor :key, :value, :next_node

    def initialize(key = nil, value = nil, next_node = nil)
      self.key = key
      self.value = value
      self.next_node = next_node
    end
  end

  def create_node(key, value, next_node = nil) = Node.new(key, value, next_node)

  def insert_node(index, key, value)
    new_node = create_node(key, value)
    bucket[index] = new_node
    increase_length
    [new_node.key, new_node.value]
  end

  def append_node(index, key, value)
    new_node = create_node(key, value)
    current_node = bucket[index]
    current_node = current_node.next_node while current_node.next_node
    current_node.next_node = new_node
    increase_length
    [new_node.key, new_node.value]
  end

  def replace_node(index, key, value)
    current_node = bucket[index]
    current_node = current_node.next_node until current_node.key == key
    current_node.value = value
    [current_node.key, current_node.value]
  end

  def add(index, key, value)
    return replace_node(index, key, value) if has?(key)
    return append_node(index, key, value) if bucket[index]

    insert_node(index, key, value)
  end

  def find_value(node, key)
    while node
      return node.value if node.key == key

      node = node.next_node
    end

    nil
  end

  def delete_head_node(index)
    value = bucket[index].value
    bucket[index] = bucket[index].next_node || nil
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

  def delete(index, key)
    return delete_head_node(index) if bucket[index].key == key

    delete_node(index, key)
  end
end
