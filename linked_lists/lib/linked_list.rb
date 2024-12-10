# frozen_string_literal: false

require_relative 'node'

# This Class manages the 'Linked List' data structure & performs list related operations.
class LinkedList
  private

  attr_accessor :head, :tail, :node

  def initialize(node = Node)
    self.node = node
    self.head = nil
    self.tail = nil
  end

  def add_first_node(value)
    new_node = node.new(value)
    @head = new_node
    @tail = new_node
  end

  def to_s
    current_node = @head
    list = ''
    until current_node.nil?
      list << "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    list << 'nil'
  end

  public

  def append(value)
    unless tail.nil?
      new_node = node.new(value)
      @tail.next_node = new_node
      @tail = new_node
      return
    end

    add_first_node(value)
  end

  def prepend(value)
    unless head.nil?
      new_node = node.new(value)
      new_node.next_node = head
      @head = new_node
      return
    end

    add_first_node(value)
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.prepend('parrot')
list.prepend('hamster')

puts list
