# frozen_string_literal: false

require_relative 'node'

# This Class manages the 'Linked List' data structure & performs list related operations.
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
end

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
