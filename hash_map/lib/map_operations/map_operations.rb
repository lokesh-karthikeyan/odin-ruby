# frozen_string_literal: true

# This Module contains 'Node' Class for 'Hash Map'.
# It also has methods that are related to 'Hash Map'.
module MapOperations
  # This Class creates 'Node' data structure for 'Hash Map'.
  class Node
    attr_accessor :key, :value, :next_node

    def initialize(key = nil, value = nil, next_node = nil)
      self.key = key
      self.value = value
      self.next_node = next_node
    end
  end
end
