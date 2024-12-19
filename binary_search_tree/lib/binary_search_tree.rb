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

  private

  attr_accessor :tree, :root, :traverse

  def initialize(array, tree = Tree, traverse = Traverse.new, quick_sort = QuickSort)
    remove_duplicates = array.uniq
    sorted_array = quick_sort.new(remove_duplicates).sorted_array
    self.traverse = traverse
    self.tree = tree.new(sorted_array)
    self.root = self.tree.root
  end
end
