# frozen_string_literal: true

require_relative 'possible_moves/possible_moves'
require_relative 'vertex/vertex'

# This Class computes the total distance (moves) between the source point & destination point.
# It also displays the intermediate paths between the source & destination.
class KnightsTravails
  def knight_moves(source, destination)
    return print_invalid_entry unless valid_inputs?(source, destination)
    return print_no_moves_needed if source == destination

    @destination = destination
    destination_vertex = level_order_lookup(source)
    path = trace_path(destination_vertex)
    clear_visited_neighbors_data
    print_shortest_path(path)
  end

  private

  attr_reader :destination
  attr_accessor :possible_moves, :vertex, :visited_neighbors

  def initialize(possible_moves = PossibleMoves.new, vertex = Vertex)
    self.possible_moves = possible_moves
    self.vertex = vertex
    self.visited_neighbors = Set.new
  end

  def valid_inputs?(source, destination) = source.all?(0..7) && destination.all?(0..7)

  def print_invalid_entry = puts('Invalid values are entered. Only the values in range of (0..7) are allowed.')

  def print_no_moves_needed = puts("You're already at the destination. '0' moves needed.")

  def create_vertex(coordinates, neighbors = nil) = vertex.new(coordinates, neighbors)

  def level_order_lookup(source, queue = [])
    new_vertex = create_vertex(source)
    queue.unshift(new_vertex)
    destination_vertex = nil

    while queue
      current_neighbor = queue.pop
      destination_vertex = next_possible_moves(current_neighbor, queue)
      return destination_vertex if destination_vertex

      visited_neighbors << current_neighbor.coordinates
    end

    destination_vertex
  end

  def next_possible_moves(neighbor, queue)
    next_moves = possible_moves.valid_moves(neighbor.coordinates)

    next_moves.each do |next_move|
      next if visited_neighbors.include?(next_move)

      new_vertex = create_vertex(next_move, neighbor)
      return new_vertex if new_vertex.coordinates == destination

      queue.unshift(new_vertex)
    end

    nil
  end

  def trace_path(current_vertex)
    path = []
    while current_vertex
      path << current_vertex.coordinates
      current_vertex = current_vertex.neighbor
    end
    path
  end

  def print_shortest_path(path)
    puts "You made it in #{path.length - 1} move(s)! Here's your path:"
    (path.length - 1).downto(0) do |index|
      return puts path[index].inspect if index.zero?

      print "#{path[index]} -> "
    end
  end

  def clear_visited_neighbors_data = (self.visited_neighbors = Set.new)
end
