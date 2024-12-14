# frozen_string_literal: true

require_relative 'hash_code/hash_code'
require_relative 'buckets/buckets'
require_relative 'buckets/bucket_overseer'
require_relative 'set_operations/set_operations'

# This Class creates an 'Hash Set' data structure.
# It contains methods that are related to 'Hash Set' related operations.
class HashSet
  private

  include BucketOverseer
  include SetOperations

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

  def set(key)
    index = hash_index(key)
    raise IndexError if invalid_index?(index)

    increase_buckets if load_exceeded?
    add(index, key)
  end
end

hash_set = HashSet.new

p hash_set.set('apple')
p hash_set.set('banana')
p hash_set.set('banana')
p hash_set.length
