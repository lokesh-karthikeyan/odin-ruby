# frozen_string_literal: true

require_relative '../node/node'

# This Class helps in building a 'Tree' like structure from the given array.
# It also contains behaviours of insertion & deletion.
class Tree
  attr_accessor :root

  def insert_as_leaf_node(value, node, is_left: true)
    new_node = create_node(value)
    if is_left
      assign_left_node(node, new_node)
      return value
    end

    assign_right_node(node, new_node)
    value
  end

  def delete_leaf_node(previous_node, current_node)
    if current_node < previous_node
      assign_left_node(previous_node, nil)
      return current_node.value
    end

    assign_right_node(previous_node, nil)
    current_node.value
  end

  def delete_node_with_single_child(previous_node, current_node)
    if current_node < previous_node
      assign_left_node(previous_node, current_node.left || current_node.right)
      return current_node.value
    end

    assign_right_node(previous_node, current_node.left || current_node.right)
    current_node.value
  end

  def delete_node_with_double_child(current_node)
    parent_node, replacement_node = inorder_successor(current_node)

    if replacement_node.left || replacement_node.right
      delete_node_with_single_child(parent_node, replacement_node)
    else
      delete_leaf_node(parent_node, replacement_node)
    end

    replace_values(current_node, replacement_node)
    current_node.value
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

  def assign_left_node(assignee_node, assignor_node) = assignee_node.left = assignor_node

  def assign_right_node(assignee_node, assignor_node) = assignee_node.right = assignor_node

  def inorder_successor(node)
    previous_node = node
    current_node = node.right

    while current_node.left
      previous_node = current_node
      current_node = current_node.left
    end
    [previous_node, current_node]
  end

  def replace_values(current_node, replacement_node) = (current_node.value = replacement_node.value)
end
