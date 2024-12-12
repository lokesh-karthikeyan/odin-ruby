# frozen_string_literal: true

# This Class creates an array of the default size & resizes if it's required.
class Buckets
  private

  def initialize
    self.store = Array.new(16)
  end

  public

  attr_accessor :store

  def resize
    new_storage = Array.new(store.length * 2)
    store.each_with_index { |value, index| new_storage[index] = value }
    @store = new_storage
  end
end
