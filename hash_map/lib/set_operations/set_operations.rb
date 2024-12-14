# frozen_string_literal: true

# This Module contains 'Node' Class for 'Hash Set'.
# It also has methods that are related to 'Hash Set'.
module SetOperations
  private

  # This Class creates 'Node' data structure for 'Hash Set'.
  class Node
    attr_accessor :key, :next_node

    def initialize(key = nil, next_node = nil)
      self.key = key
      self.next_node = next_node
    end
  end

  def create_node(key, next_node = nil) = Node.new(key, next_node)

  def insert_node(index, key)
    new_node = create_node(key)
    bucket[index] = new_node
    increase_length
    new_node.key
  end

  def append_node(index, key)
    new_node = create_node(key)
    current_node = bucket[index]
    current_node = current_node.next_node while current_node.next_node
    current_node.next_node = new_node
    increase_length
    new_node.key
  end

  def add(index, key)
    return key if has?(key)
    return append_node(index, key) if bucket[index]

    insert_node(index, key)
  end

  def find_entry(node, key)
    while node
      return true if node.key == key

      node = node.next_node
    end

    false
  end

  def delete_head_node(index)
    key_copy = bucket[index].key
    bucket[index] = bucket[index].next_node || nil
    decrease_length
    key_copy
  end

  def delete_node(index, key)
    current_node = bucket[index]

    current_node = current_node.next_node until current_node.next_node.key == key
    key_copy = current_node.next_node.key
    current_node.next_node = current_node.next_node.next_node
    decrease_length
    key_copy
  end

  def delete(index, key)
    return delete_head_node(index) if bucket[index].key == key

    delete_node(index, key)
  end
end
