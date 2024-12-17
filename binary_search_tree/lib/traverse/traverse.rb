# frozen_string_literal: true

# This Class walks over the 'Binary Search Tree' with various traversing methods.
class Traverse
  def level_order(node) = rand(1..2) > 1 ? level_order_iteration(node) : level_order_recursion(node)

  def inorder(node, stack = [], result = [])
    return result if node.nil?

    stack << node
    until stack.empty?
      node = push_nodes(node, stack, is_left: true) while node
      popped_node = stack.pop
      result << popped_node.value
      node = push_nodes(popped_node, stack, is_left: false)
    end
    result
  end

  def preorder(node, result = [])
    return result if node.nil?

    result << node.value
    preorder(node.left, result)
    preorder(node.right, result)
  end

  def postorder(node, stack = [], result = [])
    return result if node.nil?

    until stack.empty? && node.nil?
      node = push_root_and_right_nodes(node, stack) while node
      node = stack.pop
      node = right_node_exist?(node, stack) ? update_stack(node, stack) : update_result(node, result)
    end
    result
  end

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

  def push_nodes(node, stack, is_left: true)
    node = is_left ? node.left : node.right
    stack << node if node
    node
  end

  def push_root_and_right_nodes(node, stack)
    push_nodes(node, stack, is_left: false)
    stack << node if node
    node.left
  end

  def right_node_exist?(node, stack)
    return false if node.right.nil? || stack.empty?

    node.right == stack.last
  end

  def update_stack(node, stack)
    stack.pop
    stack << node
    node.right
  end

  def update_result(node, result)
    result << node.value
    nil
  end
end
