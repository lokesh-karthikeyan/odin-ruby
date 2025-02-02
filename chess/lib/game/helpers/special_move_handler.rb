# frozen_string_literal: true

require_relative 'enquire_pawn_promotion'
require_relative '../../movements/movable'
require_relative 'verifiable'

# Helper Class --> To handle special moves.
class SpecialMoveHandler
  include Movable
  include Verifiable

  def handle
    pawn_promotion_handler if pawn_promotion?
    castling_handler if castling?
    en_passant_handler if en_passant?
  end

  private

  attr_accessor :board_klass, :renderer, :active_player, :move_state, :inspector, :source, :target, :last_move

  def initialize(arguments) # rubocop:disable Metrics/AbcSize
    self.board_klass = arguments[:board_klass]
    self.renderer = arguments[:renderer]
    self.active_player = arguments[:active_player]
    self.move_state = arguments[:move_state]
    self.inspector = arguments[:inspector]
    self.source = arguments[:source]
    self.target = arguments[:target]
    self.last_move = arguments[:last_move]
  end

  def pawn_promotion_handler
    piece = EnquirePawnPromotion.piece_type(active_player)
    board_klass.replace_piece(target, piece)
    renderer.board_renderer(source)
  end

  def castling_handler
    _, column = target
    white_castling(column) if active_player.color == :white
    black_castling(column) if active_player.color == :black
  end

  def en_passant_handler
    en_passant_target = move_state.en_passant_target

    return unless white_side_en_passant?(source, target) || black_side_en_passant?(source, target)

    update_en_passant_piece(en_passant_target)
  end

  def white_castling(spot)
    rook_source = spot.eql?(6) ? [7, 7] : [7, 0]
    rook_target = spot.eql?(6) ? [7, 5] : [7, 3]

    board_klass.update_pieces(rook_source, rook_target)
    renderer.board_renderer(target)
  end

  def black_castling(spot)
    rook_source = spot.eql?(6) ? [0, 7] : [0, 0]
    rook_target = spot.eql?(6) ? [0, 5] : [0, 3]

    board_klass.update_pieces(rook_source, rook_target)
    renderer.board_renderer(target)
  end

  def white_side_en_passant?(source, target)
    active_player.color == :white && inspector.left_black_pawn?(source, target) ||
      inspector.right_black_pawn?(source, target)
  end

  def black_side_en_passant?(source, target)
    active_player.color == :black && inspector.left_white_pawn?(source, target) ||
      inspector.right_white_pawn?(source, target)
  end

  def update_en_passant_piece(en_passant_target)
    en_passant_spot = to_coordinates(en_passant_target)

    board_klass.replace_piece(en_passant_spot, ' ')
    renderer.board_renderer(target)
  end
end
