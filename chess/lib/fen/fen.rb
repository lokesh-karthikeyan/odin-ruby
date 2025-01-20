# frozen_string_literal: true

require_relative './fen_generator'
require_relative './fen_resolver'

# "Forsyth-Edwards Notation (FEN)" translator.
module FEN
  def self.generate(board, move_state) = FENGenerator.new(board, move_state).generate

  def self.resolve(fen_string) = FENResolver.new(fen_string).resolve
end
