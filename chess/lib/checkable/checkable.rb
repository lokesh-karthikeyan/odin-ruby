# frozen_string_literal: true

require_relative 'horizontal_checkable'
require_relative 'vertical_checkable'
require_relative 'diagonal_checkable'
require_relative 'knight_checkable'

# Inspect King's safety if it's in a position of Check (or) Mate.
module Checkable
  def self.enemy_whereabouts(board, spot)
    horizontal_inspection = HorizontalCheckable.new(board, spot).enemy_whereabouts
    vertical_inspection = VerticalCheckable.new(board, spot).enemy_whereabouts
    diagonal_inspection = DiagonalCheckable.new(board, spot).enemy_whereabouts
    knight_path_inspection = KnightCheckable.new(board, spot).enemy_whereabouts

    horizontal_inspection + vertical_inspection + diagonal_inspection + knight_path_inspection
  end
end
