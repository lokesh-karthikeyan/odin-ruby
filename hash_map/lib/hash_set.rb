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

  def has?(key)
    index = hash_index(key)
    head_node = bucket[index]
    return false unless head_node

    find_entry(head_node, key)
  end

  def remove(key)
    index = hash_index(key)
    return nil unless has?(key)

    delete(index, key)
  end

  def clear
    self.bucket = buckets.new
    self.length = 0
  end

  def keys
    bucket.each_with_object([]) do |node, key_list|
      while node
        key_list << node.key
        node = node.next_node
      end
    end
  end
end

hash = HashSet.new

hash.set('apple')
hash.set('banana')
hash.set('carrot')
hash.set('dog')
hash.set('elephant')
hash.set('frog')
hash.set('grape')
hash.set('hat')
hash.set('ice cream')
hash.set('jacket')
hash.set('kite')
hash.set('lion')

p '***********'
p hash.remove('appl')
p hash.remove('elephant')

p '***********'
p hash.length

hash.clear

p hash.length
