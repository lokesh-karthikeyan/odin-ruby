# frozen_string_literal: true

# This Class defines a structure of a node (Data & the information to the next node) for the Linked list.
class Node
  private

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
  end

  public

  attr_accessor :value, :next_node
end
