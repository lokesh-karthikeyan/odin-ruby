# frozen_string_literal: true

# This Class creates a node for a linked list. (Contains key, value & the pointer to next node)
class Node
  private

  def initialize(key = nil, value = nil, next_node = nil)
    self.key = key
    self.value = value
    self.next_node = next_node
  end

  public

  attr_accessor :key, :value, :next_node
end
