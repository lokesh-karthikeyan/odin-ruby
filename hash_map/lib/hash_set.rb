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

    add(index, key)
    increase_buckets if load_exceeded?
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

  def test
    p "Load Levels = #{load_levels}"
    p "Capacity = #{capacity}"
    non_indices = []
    bucket.each_with_index { |v, i| non_indices << i if v }
    p "Occupied Indices = #{non_indices}"
    p "Total entries = #{length}"
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

hash.test
puts '******************************************'

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

hash.test
puts '******************************************'

hash.set('moon')
hash.test

puts '******************************************'

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

hash.test
puts '******************************************'

hash.set('zzapple')
hash.set('zzbanana')
hash.set('zzcarrot')
hash.set('zzdog')
hash.set('zzelephant')
hash.set('zzfrog')
hash.set('zzgrape')
hash.set('zzhat')
hash.set('zzice cream')
hash.set('zzjacket')
hash.set('zzkite')
hash.set('zzlion')

hash.test

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

puts '*******Length()*******************************************'
p hash.length
puts '*******Clear()*******************************************'
hash.clear

hash.test

puts '******************************************'
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

hash.test
puts '******************************************'

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

hash.test
puts '******************************************'

hash.set('moon')
hash.test

puts '******************************************'
