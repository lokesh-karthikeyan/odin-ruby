# frozen_string_literal: true

require_relative 'quick_sort/quick_sort'
require_relative 'tree/tree'
require_relative 'traverse/traverse'

# This Class creates & contains behaviours related to 'Binary Search Tree'.
class BinarySearchTree
  def view(node = @root, prefix = '', is_left: true)
    view(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    view(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end

  def insert(value)
    previous_node, current_node = find_family(value, @root)

    return value if current_node
    return create_tree([value]) if previous_node.nil? && current_node.nil?

    if value < previous_node.value
      binary_search_tree.insert_as_leaf_node(value, previous_node, is_left: true)
    else
      binary_search_tree.insert_as_leaf_node(value, previous_node, is_left: false)
    end
    value
  end

  def delete(value)
    previous_node, current_node = find_family(value, @root)

    return nil if current_node.nil?
    return binary_search_tree.delete_leaf_node(previous_node, current_node) if leaf_node?(current_node)

    if double_child?(current_node)
      binary_search_tree.delete_node_with_double_child(current_node)
    else
      binary_search_tree.delete_node_with_single_child(previous_node, current_node)
    end
    value
  end

  def find(value) = find_family(value, @root).last&.value || nil

  def level_order(&block)
    nodes_in_the_tree = traverse.level_order(@root)
    return nodes_in_the_tree unless block_given?

    nodes_in_the_tree.map do |value|
      block.call(value)
    end
  end

  private

  attr_accessor :tree, :root, :traverse, :binary_search_tree

  def initialize(array, tree = Tree, traverse = Traverse.new, quick_sort = QuickSort)
    remove_duplicates = array.uniq
    sorted_array = quick_sort.new(remove_duplicates).sorted_array
    self.traverse = traverse
    self.tree = tree
    create_tree(sorted_array)
  end

  def create_tree(array)
    self.binary_search_tree = tree.new(array)
    self.root = binary_search_tree.root
    root&.value
  end

  def find_family(value, current_node, previous_node = nil)
    while current_node
      return [previous_node, current_node] if value == current_node.value

      previous_node = current_node
      current_node = value < current_node.value ? current_node.left : current_node.right
    end
    [previous_node, current_node]
  end

  def leaf_node?(node) = node.left.nil? && node.right.nil?

  def double_child?(node) = node.left && node.right
end
