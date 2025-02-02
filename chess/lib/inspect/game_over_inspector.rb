# frozen_string_literal: true

require_relative '../movements/movements'
require_relative '../checkable/checkable'
require_relative '../movements/movable'

# Inspects the winning scenarios of a game.
class GameOverInspector
  include Movable

  def check?(allies)
    king_spot = find_king(allies)
    Checkable.enemy_whereabouts(board, king_spot).any?
  end

  def mate?(game_state, movable_pieces) = game_state.check? && movable_pieces.empty?

  def stale_mate?(game_state, movable_pieces) = !game_state.check? && movable_pieces.empty?

  def three_fold_repetition?(logs) = logs.values.any? { |count| count >= 3 }

  def fifty_move_rule? = move_state.half_move_clock >= 100

  private

  attr_accessor :board, :move_state

  def initialize(board, move_state)
    self.board = board
    self.move_state = move_state
  end
end
