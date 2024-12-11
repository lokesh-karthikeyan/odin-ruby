# frozen_string_literal: false

require_relative 'node'

# This Class manages the 'Linked List' data structure & performs list related operations.

# rubocop:disable Metrics/ClassLength
class LinkedList
  private

  attr_accessor :front, :rear, :node

  def initialize(node = Node)
    self.node = node
    self.front = nil
    self.rear = nil
  end

  def add_first_node(value)
    new_node = node.new(value)
    @front = new_node
    @rear = new_node
  end

  def to_s
    current_node = @front
    list = ''

    until current_node.nil?
      list << "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    list << 'nil'
  end

  def previous_and_current_nodes(index)
    count = 0
    previous_node = nil
    current_node = front

    until current_node.nil?
      return [previous_node, current_node] if count.eql?(index)

      previous_node = current_node
      current_node = current_node.next_node
      count += 1
    end
  end

  def move_front
    value = head
    @front = front.next_node
    value
  end

  def insert_between(value, index)
    previous_node, current_node = previous_and_current_nodes(index)
    new_node = node.new(value, current_node)
    previous_node.next_node = new_node
    nil
  end

  def remove_between(index)
    previous_node, current_node = previous_and_current_nodes(index)
    value = current_node.value
    previous_node.next_node = current_node.next_node
    value
  end

  public

  def append(value)
    return add_first_node(value) if rear.nil?

    new_node = node.new(value)
    @rear.next_node = new_node
    @rear = new_node
  end

  def prepend(value)
    return add_first_node(value) if front.nil?

    new_node = node.new(value)
    new_node.next_node = front
    @front = new_node
  end

  def size
    length = 0
    current_node = front

    until current_node.nil?
      length += 1
      current_node = current_node.next_node
    end

    length
  end

  def head
    return front.value if front

    'nil'
  end

  def tail
    return rear.value if rear

    'nil'
  end

  def at(index)
    current_node = front
    count = 0

    until current_node.nil?
      return current_node.value if count.eql?(index)

      count += 1
      current_node = current_node.next_node
    end

    'nil'
  end

  def pop
    current_node = front

    current_node = current_node.next_node until current_node.next_node.eql?(rear)

    value = current_node.next_node.value
    current_node.next_node = nil
    @rear = current_node

    value
  end

  def contains?(value)
    current_node = front

    until current_node.nil?
      return true if current_node.value.eql?(value)

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = front
    index = 0

    until current_node.nil?
      return index if current_node.value.eql?(value)

      index += 1
      current_node = current_node.next_node
    end

    'nil'
  end

  def insert_at(value, index)
    insert_between(value, index) if index.between?(1, size - 1)
    prepend(value) if index.eql?(0)
    append(value) if index.eql?(size)
    return 'nil' if index.negative? || index > size

    self
  end

  def remove_at(index)
    return remove_between(index) if index.between?(1, size - 2)
    return move_front if index.zero? && size.positive?
    return pop if index.eql?(size - 1)

    'nil' if index.negative? || index >= size
  end
end
# rubocop:enable Metrics/ClassLength

list = LinkedList.new

puts list.remove_at(100)
list.append('dog')
list.prepend('cat')
puts list
puts "The size of the list is = #{list.size}"
list.insert_at('elephant', 4)
list.insert_at('elephant', 1)
puts list
puts "The first node element is = #{list.head}"
puts "The last node element is = #{list.tail}"
puts "The element in index '5' is #{list.at(5)}"
puts "The element in index '2' is #{list.at(2)}"
list.insert_at('parrot', 3)
puts list
list.pop
puts list
puts "Does list has 'cat'? : #{list.contains?('cat')}"
puts "Does list has 'parrot'? : #{list.contains?('parrot')}"
puts "Locate 'parrot' from the list : #{list.find('parrot')}"
puts "Locate 'cat' from the list : #{list.find('cat')}"
list.remove_at(99)
list.remove_at(1)
puts list
