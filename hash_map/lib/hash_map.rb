# frozen_string_literal: true

require_relative 'hash_code'
require_relative 'buckets'
require_relative 'linked_list'

# This Class creates an instance of 'Hash Map' data structure and performs hash operations.
class HashMap
  private

  include LinkedList

  LOAD_FACTOR = 0.75

  attr_accessor :hash_code, :bucket_stash, :bucket, :tail

  def initialize(hash_code = HashCode.new, bucket_stash = Buckets.new)
    self.hash_code = hash_code
    self.bucket_stash = bucket_stash
    self.bucket = bucket_stash.store
    self.tail = []
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

    add(index, key, value)
  end

  def get(key)
    index = compute_index(key)
    is_present = nil
    current_node = bucket[index]

    traverse_nodes(current_node) { return is_present = current_node.value if current_node.key == key }
    is_present
  end

  def remove(key)
    index = compute_index(key)

    return nil unless entries.map(&:first).include?(key)

    return delete_first_node(index) if bucket[index].next_node.nil?

    delete_node(index, key)
  end

  def entries
    key_value_pairs = []

    bucket.each { |item| traverse_nodes(item) { key_value_pairs << [item.key, item.value] } if item }

    key_value_pairs
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

p my_hash.remove('kitee')
p my_hash.remove('kite')

p my_hash.get('lionn')
p my_hash.get('carrot')
#
# puts my_hash.has?('carrot')
# puts my_hash.has?('bear')
