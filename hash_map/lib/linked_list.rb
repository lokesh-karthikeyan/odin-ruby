# frozen_string_literal: true

require_relative 'node'

# This Class creates an instance of a 'Linked List' data structure.
# It also contains methods which performs list related operations.
class LinkedList
  private

  attr_accessor :tail

  def initialize(node = Node)
    @node = node
    self.tail = []
  end

  def create_node(key = nil, value = nil, next_node = nil)
    @node.new(key, value, next_node)
  end

  def append_first_node(index, key, value)
    new_node = create_node(key, value)
    pointer[index] = new_node
    tail[index] = new_node
  end

  def append_node(index, key, value)
    new_node = create_node(key, value)
    tail[index].next_node = new_node
    tail[index] = new_node
  end

  public

  attr_accessor :pointer

  def add(index, key, value)
    return append_first_node(index, key, value) if pointer[index].nil?

    append_node(index, key, value) if pointer[index]
  end

  def pull_value(index, key)
    current_node = pointer[index]

    until current_node.nil?
      return current_node.value if current_node.key == key

      current_node = current_node.next_node
    end

    'nil'
  end

  def valid_key?(index, key)
    current_node = pointer[index]

    until current_node.nil?
      return true if current_node.key == key

      current_node = current_node.next_node
    end

    false
  end
end
