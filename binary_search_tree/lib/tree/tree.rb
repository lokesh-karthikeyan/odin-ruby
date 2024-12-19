# frozen_string_literal: true

require_relative '../node/node'

# This Class helps in building a 'Tree' like structure from the given array.
class Tree
  attr_accessor :root

  def insert_node(value, previous_node = nil, root_node = @root)
    return insert_first_node(value) if root_node.nil?

    while root_node
      return value if value == root_node.value

      previous_node = root_node
      root_node = value < root_node.value ? root_node.left : root_node.right
    end

    return insert_as_leaf_node(value, previous_node, is_left: true) if value < previous_node.value

    insert_as_leaf_node(value, previous_node, is_left: false)
  end

  private

  attr_accessor :node

  def initialize(array, node = Node)
    self.node = node
    self.root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    middle_index = array.length / 2
    root_node = create_node(array[middle_index])

    root_node.left = build_tree(array[...middle_index])
    root_node.right = build_tree(array[middle_index + 1..])
    root_node
  end

  def create_node(value = nil, left = nil, right = nil) = node.new(value, left, right)

  def insert_first_node(value)
    self.root = self.class.new([value]).root
    value
  end

  def insert_as_leaf_node(value, node, is_left: true)
    unless is_left
      node.right = create_node(value)
      return value
    end
    node.left = create_node(value)
    value
  end
end
