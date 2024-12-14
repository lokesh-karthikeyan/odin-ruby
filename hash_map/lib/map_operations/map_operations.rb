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

  def add(index, key, value)
    return append_node(index, key, value) if bucket[index]

    insert_node(index, key, value)
  end
end
