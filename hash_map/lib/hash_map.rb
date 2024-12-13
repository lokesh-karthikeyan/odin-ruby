# frozen_string_literal: true

require_relative 'hash_indexable'
require_relative 'buckets'
require_relative 'linked_list'

# This Class creates an instance of 'Hash Map' data structure and performs hash operations.
class HashMap
  private

  include HashIndexable
  include LinkedList

  LOAD_FACTOR = 0.75

  attr_accessor :bucket_stash, :bucket, :tail

  def initialize(bucket_stash = Buckets.new)
    self.bucket_stash = bucket_stash
    self.bucket = bucket_stash.store
    self.tail = []
    self.length = 0
  end

  def invalid_index?(index) = index.negative? || index >= bucket.length

  def increase_length = self.length += 1

  def decrease_length = self.length -= 1

  def load_levels = bucket.size * LOAD_FACTOR

  def increase_buckets
    bucket_stash.resize
    self.bucket = bucket_stash.store
  end

  public

  attr_accessor :length

  def set(key, value)
    index = compute_index(key)
    raise IndexError if invalid_index?(index)

    add(index, key, value)
    increase_buckets if length > load_levels
  end

  def get(key)
    index = compute_index(key)
    is_present = nil
    current_node = bucket[index]

    while current_node
      return is_present = current_node.value if current_node.key == key

      current_node = current_node.next_node
    end
    is_present
  end

  def has?(key) = !!get(key)

  def remove(key)
    index = compute_index(key)

    return nil unless has?(key)
    return delete_first_node(index) if bucket[index].next_node.nil?

    delete_node(index, key)
  end

  def clear
    self.bucket_stash = bucket_stash.new_stash
    self.bucket = bucket_stash.store
    self.length = 0
  end

  def keys = entries.map(&:first)

  def values = entries.map(&:last)

  def entries
    bucket.each_with_object([]) do |item, entry_list|
      while item
        entry_list << [item.key, item.value]
        item = item.next_node
      end
    end
  end

  def test
    p "Bucket size = #{bucket.length}"
    p "Load Levels = #{load_levels}"
    p "Entries Length = #{length}"
    indices = []
    bucket.each_with_index { |item, index| indices << index if item }
    p "Non-nil indices: #{indices}"
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

my_hash.test
# p my_hash.entries

# my_hash.set('apple', 'redddd')
# my_hash.set('banana', 'yellowwww')
# my_hash.set('carrot', 'orangeeee')
# my_hash.set('dog', 'brownnn')
# my_hash.set('elephant', 'grayyyyy')
# my_hash.set('frog', 'greennnnnn')
# my_hash.set('grape', 'purpleeeee')
# my_hash.set('hat', 'blackkkkk')
# my_hash.set('ice cream', 'whiteeeeee')
# my_hash.set('jacket', 'blueee')
# my_hash.set('kite', 'pinkkkkkkk')
# my_hash.set('lion', 'goldennnn')

my_hash.set('moon', 'silver')

# my_hash.test
# p my_hash.entries

my_hash.set('kite', 'crimson')
my_hash.set('sun', 'crimson')
my_hash.set('space', 'black')
my_hash.test

# p my_hash.entries
# p my_hash.has?('lion')
# p my_hash.remove('kitee')
# p my_hash.remove('kite')
#
p my_hash.get('lionn')
p my_hash.get('carrot')

p my_hash.has?('carrot')
p my_hash.has?('bear')
p my_hash.has?('space')

p my_hash.keys
p my_hash.values

p my_hash.remove('lion')

p my_hash.keys
p my_hash.values
p my_hash.entries
#
# my_hash.clear
p my_hash.remove('lion')
#
# p my_hash.entries
#
# p my_hash.length
#
# my_hash.set('apple', 'red')
# my_hash.set('banana', 'yellow')
# my_hash.set('carrot', 'orange')
# my_hash.set('dog', 'brown')
# my_hash.set('elephant', 'gray')
# my_hash.set('frog', 'green')
# my_hash.set('grape', 'purple')
# my_hash.set('hat', 'black')
# my_hash.set('ice cream', 'white')
# my_hash.set('jacket', 'blue')
# my_hash.set('kite', 'pink')
# my_hash.set('lion', 'golden')
# p my_hash.length
#
# # p my_hash.entries
# p my_hash.keys
# p my_hash.values
#
# my_hash.clear
#
# p my_hash.entries
