# frozen_string_literal: true

require_relative 'node'

# This Class creates an instance of a 'Linked List' data structure.
# It also contains methods which performs list related operations.
class LinkedList
  private

  attr_accessor :front, :rear

  def initialize(node = Node)
    @node = node
    self.front = nil
    self.rear = nil
  end

  def create_node(key = nil, value = nil, next_node = nil)
    @node.new(key, value, next_node)
  end
end
