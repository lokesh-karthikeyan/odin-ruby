# frozen_string_literal: true

# Information related to the special moves.
MoveState = Struct.new(:active_color, :white_king_side_castle?, :white_queen_side_castle?, :black_king_side_castle?,
                       :black_queen_side_castle?, :en_passant_target, :half_move_clock, :full_move_number)
