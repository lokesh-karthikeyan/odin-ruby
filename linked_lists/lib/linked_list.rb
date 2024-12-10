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
    new_node = node.new(value)

    unless tail.nil?
      @tail.next_node = new_node
      @tail = new_node
      return
    end

    @head = new_node
    @tail = new_node
  end

  def prepend(value)
    new_node = node.new(value)

    unless head.nil?
      new_node.next_node = head
      @head = new_node
      return
    end

    @head = new_node
    @tail = new_node
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.prepend('parrot')
list.prepend('hamster')

puts list
