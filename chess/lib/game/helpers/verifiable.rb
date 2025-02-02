# frozen_string_literal: true

# Contains small methods that does some checks.
module Verifiable
  def check? = game_state.check?

  def mate? = game_state.mate?

  def stale_mate? = game_state.stale_mate?

  def quit?(feedback) = feedback == 'q'

  def save?(feedback) = feedback == 's'

  def pawn_promotion? = inspector.pawn_promotion?(target, active_player.color)

  def castling? = inspector.castling?(source, target)

  def en_passant? = !last_move.nil? && inspector.en_passant?(last_move.first, last_move.last)
end
