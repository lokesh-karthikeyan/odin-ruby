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
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.prepend('parrot')
list.prepend('hamster')
list.append('snake')

puts list
puts list.size
