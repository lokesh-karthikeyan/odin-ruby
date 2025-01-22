# frozen_string_literal: true

# Stores all the paths, that a piece can move inside the board.
module Routes
  HORIZONTAL = [[0, -1], [0, 1]].freeze
  VERTICAL = [[-1, 0], [1, 0]].freeze
  DIAGONAL = [[-1, 1], [1, 1], [1, -1], [-1, -1]].freeze
  KNIGHT = [[-2, 1], [-1, 2], [2, 1], [1, 2], [2, -1], [1, -2], [-2, -1], [-1, -2]].freeze
  KING_SIDE_CASTLE = [0, 2].freeze
  QUEEN_SIDE_CASTLE = [0, -2].freeze
  BLACK_PAWN_SINGLE_ADVANCE = [1, 0].freeze
  BLACK_PAWN_DOUBLE_ADVANCE = [2, 0].freeze
  BLACK_PAWN_LEFT_CAPTURE = [1, -1].freeze
  BLACK_PAWN_RIGHT_CAPTURE = [1, 1].freeze
  WHITE_PAWN_SINGLE_ADVANCE = [-1, 0].freeze
  WHITE_PAWN_DOUBLE_ADVANCE = [-2, 0].freeze
  WHITE_PAWN_LEFT_CAPTURE = [-1, -1].freeze
  WHITE_PAWN_RIGHT_CAPTURE = [-1, 1].freeze
  LEFT_SIDE_EN_PASSANT = [0, -1].freeze
  RIGHT_SIDE_EN_PASSANT = [0, 1].freeze
end
