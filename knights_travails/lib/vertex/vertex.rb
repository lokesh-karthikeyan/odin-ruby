# frozen_string_literal: true

# This Class creates a 'Vertex' like Data Structure for a graph.
# It contains a neighbor part, and a coordinates part. The 'Neighbor' part acts like an edges between the vertices.
class Vertex
  attr_accessor :neighbor, :coordinates

  def initialize(coordinates = nil, neighbor = nil)
    self.neighbor = neighbor
    self.coordinates = coordinates
  end
end
