# frozen_string_literal: true

require_relative 'box/box'
require_relative 'piece/piece'

# Creates instances of box object which contains a piece object.
class BoxFactory
  class << self
    def create_boxes
      piece = Piece.new('', '', '')
      Box.new(piece, '')
    end
  end
end
