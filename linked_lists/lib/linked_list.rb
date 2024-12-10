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

  public

  def append(value)
    unless rear.nil?
      new_node = node.new(value)
      @rear.next_node = new_node
      @rear = new_node
      return
    end

    add_first_node(value)
  end

  def prepend(value)
    unless front.nil?
      new_node = node.new(value)
      new_node.next_node = front
      @front = new_node
      return
    end

    add_first_node(value)
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
    if index.between?(1, size - 1)
      previous_node, current_node = previous_and_current_nodes(index)
      new_node = node.new(value, current_node)
      previous_node.next_node = new_node
    end

    prepend(value) if index.eql?(0)
    append(value) if index.eql?(size)
    return 'nil' if index.negative? || index > size

    self
  end

  def remove_at(index)
    return move_front if index.zero?
    return pop if index.eql?(size - 1)

    return 'nil' if index.negative? || index >= size

    return unless index.between?(1, size - 2)

    previous_node, current_node = previous_and_current_nodes(index)
    value = current_node.value
    previous_node.next_node = current_node.next_node
    value
  end
end
# rubocop:enable Metrics/ClassLength

list = LinkedList.new

list.append('dog')
list.append('cat')
list.prepend('parrot')
list.prepend('hamster')
list.append('snake')

puts list
puts list.size
puts list.head
puts list.tail
puts "The element is '#{list.at(5)}'"
puts "The element is '#{list.at(0)}'"
puts list.pop
puts list
puts list.contains?('raccoon')
puts list.contains?('cat')

puts list.find('raccoon')
puts list.find('cat')

puts list.insert_at('elephant', 0)
puts list.insert_at('bear', 5)
puts list.insert_at('frog', -2)
puts list.insert_at('squirrel', 23)

puts list.remove_at(0)
puts list
puts list.remove_at(-1)
puts list
puts list.remove_at(90)
puts list
puts list.remove_at(3)
puts list
puts list.remove_at(3)
puts list
puts list.remove_at(1)
puts list
puts list.remove_at(0)
puts list
puts list.remove_at(0)
puts list
