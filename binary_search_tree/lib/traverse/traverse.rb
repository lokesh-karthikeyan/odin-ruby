# frozen_string_literal: true

# This Class walks over the 'Binary Search Tree' with various traversing methods.
class Traverse
  def level_order(node) = rand(1..2) > 1 ? level_order_iteration(node) : level_order_recursion(node)

  private

  def level_order_iteration(node, queue = [], result = [])
    return result if node.nil?

    queue.push(node)
    until queue.empty?
      node = queue.shift
      result << node.value
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
    result
  end

  def level_order_recursion(node, queue = [], result = [])
    return result if node.nil? && queue.empty?

    result << node.value
    queue.push(node.left) if node.left
    queue.push(node.right) if node.right
    next_node = queue.shift
    level_order_recursion(next_node, queue, result)
  end
end
