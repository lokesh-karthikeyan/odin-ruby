# frozen_string_literal: true

require_relative 'hash_code/hash_code'
require_relative 'buckets/buckets'
require_relative 'buckets/bucket_overseer'
require_relative 'map_operations/map_operations'

# This Class creates an 'Hash Map' data structure.
# It contains methods that are related to 'Hash Map' related operations.
class HashMap
  private

  include BucketOverseer
  include MapOperations

  attr_accessor :hash_code, :buckets, :bucket

  def initialize(hash_code = HashCode, buckets = Buckets)
    self.hash_code = hash_code
    self.buckets = buckets
    self.bucket = buckets.new
    self.length = 0
  end

  def increase_length = self.length += 1

  def decrease_length = self.length -= 1

  def hash(key) = hash_code.generate(key)

  def hash_index(key) = hash(key) % capacity

  def invalid_index?(index) = index.negative? || index >= capacity

  public

  attr_accessor :length

  def set(key, value)
    index = hash_index(key)
    raise IndexError if invalid_index?(index)

    add(index, key, value)
    increase_buckets if load_exceeded?
  end

  def get(key)
    index = hash_index(key)
    head_node = bucket[index]
    return nil unless head_node

    find_value(head_node, key)
  end

  def has?(key) = !!get(key)

  def remove(key)
    index = hash_index(key)
    return nil unless has?(key)

    delete(index, key)
  end

  def clear
    self.bucket = buckets.new
    self.length = 0
  end

  def keys = entries.map(&:first)

  def values = entries.map(&:last)

  def entries
    bucket.each_with_object([]) do |node, entry_list|
      while node
        entry_list << [node.key, node.value]
        node = node.next_node
      end
    end
  end
end
