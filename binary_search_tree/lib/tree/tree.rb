# frozen_string_literal: true

require_relative '../node/node'

# This Class helps in building a 'Tree' like structure from the given array.
class Tree
  attr_accessor :root

  def view(node = @root, prefix = '', is_left: true)
    view(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    view(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
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
end
