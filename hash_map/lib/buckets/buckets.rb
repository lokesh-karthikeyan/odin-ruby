# frozen_string_literal: true

# This Class creates an 'Array' of the given length.
class Buckets
  class << self
    def new(size = 16)
      Array.new(size)
    end
  end
end
