# frozen_string_literal: true

require_relative 'hash_code'
require_relative 'buckets'
require_relative 'linked_list/linked_list'

# This Class creates an instance of 'Hash Map' data structure and performs hash operations.
class HashMap
  private

  LOAD_FACTOR = 0.75

  attr_accessor :hash_code, :bucket_stash, :bucket, :list

  def initialize(hash_code = HashCode.new, bucket_stash = Buckets.new, list = LinkedList.new)
    self.hash_code = hash_code
    self.bucket_stash = bucket_stash
    self.bucket = bucket_stash.store
    self.list = list
    self.list.pointer = bucket
  end

  def compute_index(key)
    key = hash_code.generate(key)
    key % 16
  end

  def invalid_index?(index) = index.negative? || index >= bucket.length

  public

  def set(key, value)
    index = compute_index(key)
    raise IndexError if invalid_index?(index)

    list.add(index, key, value)
  end
end

my_hash = HashMap.new

my_hash.set('apple', 'red')
my_hash.set('banana', 'yellow')
my_hash.set('carrot', 'orange')
my_hash.set('dog', 'brown')
my_hash.set('elephant', 'gray')
my_hash.set('frog', 'green')
my_hash.set('grape', 'purple')
my_hash.set('hat', 'black')
my_hash.set('ice cream', 'white')
my_hash.set('jacket', 'blue')
my_hash.set('kite', 'pink')
my_hash.set('lion', 'golden')
