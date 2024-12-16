# frozen_string_literal: true

# This Class helps in creating a 'Node' like structure for the 'Binary Search Tree'.
# This Data Structure contains a value part & two pointers to other nodes.
class Node
  include Comparable

  attr_accessor :left, :value, :right

  private

  def initialize(value = nil, left = nil, right = nil)
    self.value = value
    self.left = left
    self.right = right
  end

  def <=>(other) = (value <=> other.value)
end
