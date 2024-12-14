# frozen_string_literal: true

# This Module contains 'Node' Class for 'Hash Set'.
# It also has methods that are related to 'Hash Set'.
module SetOperations
  # This Class creates 'Node' data structure for 'Hash Set'.
  class Node
    attr_accessor :key, :next_node

    def initialize(key = nil, next_node = nil)
      self.key = key
      self.next_node = next_node
    end
  end
end
