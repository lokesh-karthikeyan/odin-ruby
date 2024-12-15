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

  def test
    p "Load Levels = #{load_levels}"
    p "Capacity = #{capacity}"
    non_indices = []
    bucket.each_with_index { |v, i| non_indices << i if v }
    p "Occupied Indices = #{non_indices}"
    p "Total entries = #{length}"
  end
end

hash = HashMap.new

hash.set('apple', 'red')
hash.set('banana', 'yellow')
hash.set('carrot', 'orange')
hash.set('dog', 'brown')
hash.set('elephant', 'gray')
hash.set('frog', 'green')
hash.set('grape', 'purple')
hash.set('hat', 'black')
hash.set('ice cream', 'white')
hash.set('jacket', 'blue')
hash.set('kite', 'pink')
hash.set('lion', 'golden')

hash.test
# p hash.entries
puts '******************************************'

hash.set('apple', 'green')
hash.set('banana', 'brown')
hash.set('carrot', 'light orange')
hash.set('dog', 'black')
hash.set('elephant', 'cement')
hash.set('frog', 'yellow')
hash.set('grape', 'lime')
hash.set('hat', 'blue')
hash.set('ice cream', 'green')
hash.set('jacket', 'rose')
hash.set('kite', 'white')
hash.set('lion', 'gold')

# p hash.entries
hash.test

puts '******************************************'

hash.set('moon', 'silver')
hash.test

puts '******************************************'

hash.set('apple', 'red')
hash.set('banana', 'yellow')
hash.set('carrot', 'orange')
hash.set('dog', 'brown')
hash.set('elephant', 'gray')
hash.set('frog', 'green')
hash.set('grape', 'purple')
hash.set('hat', 'black')
hash.set('ice cream', 'white')
hash.set('jacket', 'blue')
hash.set('kite', 'pink')
hash.set('lion', 'golden')

hash.test

puts '******************************************'

hash.set('zzapple', 'red')
hash.set('zzbanana', 'yellow')
hash.set('zzcarrot', 'orange')
hash.set('zzdog', 'brown')
hash.set('zzelephant', 'gray')
hash.set('zzfrog', 'green')
hash.set('zzgrape', 'purple')
hash.set('zzhat', 'black')
hash.set('zzice cream', 'white')
hash.set('zzjacket', 'blue')
hash.set('zzkite', 'pink')
hash.set('zzlion', 'golden')

hash.test

puts '********Get()******************************************'

p hash.get('zzjacket')
p hash.get('zzjackett')
p hash.get('ice cream')
p hash.get('')

puts '************Has()**************************************'

p hash.has?('zzelephant')
p hash.has?('elephantt')
p hash.has?('')
p hash.has?('dog')

puts '*******Remove()*******************************************'

p hash.remove('zzapple')
p hash.remove('zzbanana')
p hash.remove('zzcarrot')
p hash.remove('zzdog')
p hash.remove('zzelephant')
p hash.remove('zzfrog')
p hash.remove('zzgrape')
p hash.remove('zzhat')
p hash.remove('zzice cream')
p hash.remove('zzjacket')
p hash.remove('zzkite')
p hash.remove('zzlion')

hash.test

puts '*******Keys()**********************************************'

p hash.keys
puts '*******Values()*******************************************'
p hash.values
puts '*******Length()*******************************************'
p hash.length
puts '*******Entries()*******************************************'
p hash.entries

puts '*******Clear()*******************************************'
hash.clear
hash.test

puts '******************************************'

hash.set('apple', 'red')
hash.set('banana', 'yellow')
hash.set('carrot', 'orange')
hash.set('dog', 'brown')
hash.set('elephant', 'gray')
hash.set('frog', 'green')
hash.set('grape', 'purple')
hash.set('hat', 'black')
hash.set('ice cream', 'white')
hash.set('jacket', 'blue')
hash.set('kite', 'pink')
hash.set('lion', 'golden')

hash.test
puts '******************************************'

hash.set('apple', 'green')
hash.set('banana', 'brown')
hash.set('carrot', 'light orange')
hash.set('dog', 'black')
hash.set('elephant', 'cement')
hash.set('frog', 'yellow')
hash.set('grape', 'lime')
hash.set('hat', 'blue')
hash.set('ice cream', 'green')
hash.set('jacket', 'rose')
hash.set('kite', 'white')
hash.set('lion', 'gold')

hash.test

puts '******************************************'

hash.set('moon', 'silver')
hash.test
