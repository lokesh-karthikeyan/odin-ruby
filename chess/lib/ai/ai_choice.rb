# frozen_string_literal: true

require_relative '../movements/movable'
require_relative '../colorable/colorable'
require_relative 'next_best_move'

# AI chooses source, target, & a piece for "Pawn Promotion."
class AIChoice
  class << self
    include Movable
    using Colorable

    def source_piece(board, move_state, player_name)
      next_best_move = NextBestMove.new(board, move_state)
      self.source, self.target = next_best_move.determine_move
      validate_source_and_target(source, target)
      print_source_piece_selection(player_name)
      source
    end

    def target_spot(player_name)
      print_target_piece_selection(player_name)
      target
    end

    def pawn_promotion(player_name)
      print_pawn_promotion_selection(player_name)
      'q'
    end

    private

    attr_accessor :source, :target

    def validate_source_and_target(source, target)
      self.source = source.empty? ? '__' : spot_label(source)
      self.target = target.empty? ? '__' : spot_label(target)
    end

    def print_source_piece_selection(player_name)
      source_piece = <<~SOURCE_PIECE
        #{player_name.color_fg(:blue)} #{'picks the piece on the spot -->'.color_fg(:light_cyan)} #{source.color_fg(:green)}
      SOURCE_PIECE
      puts source_piece.color_fg(:light_cyan)
    end

    def print_target_piece_selection(player_name)
      target_piece = <<~TARGET_PIECE
        #{player_name.color_fg(:blue)} #{'places the piece on the spot -->'.color_fg(:light_cyan)} #{target.color_fg(:green)}
      TARGET_PIECE
      puts target_piece.color_fg(:light_cyan)
    end

    def print_pawn_promotion_selection(player_name)
      pawn_promotion = <<~PAWN_PROMOTION
        #{player_name.color_fg(:blue)} #{'chooses the "Pawn" to be promoted as -->'.color_fg(:light_cyan)} #{'QUEEN'.color_fg(:green)}
      PAWN_PROMOTION
      puts pawn_promotion.color_fg(:light_cyan)
    end
  end
end
