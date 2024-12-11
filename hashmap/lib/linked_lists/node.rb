# frozen_string_literal: true

# This Class creates a node for a linked list. (Contains data & the pointer to next node)
class Node
  private

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
  end

  public

  attr_accessor :value, :next_node
end
