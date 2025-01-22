# frozen_string_literal: true

require_relative '../movements/routes'

# Locates the enemy piece & inspects it's type.
module InspectEnemyPiece
  def explore_path(route, location = spot, enemy_spot = [])
    loop do
      location = compute_position(route, location)
      break unless range?(location) && null_piece?(location)
    end

    enemy_spot << location if range?(location) && enemy?(location)
    enemy_spot
  end

  def king_nearby?(location)
    adjacent_locations = self.class::ROUTES.map { |route| compute_position(route, spot) }

    king?(spot) && adjacent_locations.include?(location) && king?(location)
  end

  def pawn_nearby?(location)
    king_piece_color = color(spot)

    routes = if king_piece_color.eql?(:black)
               [Routes::BLACK_PAWN_LEFT_CAPTURE] + [Routes::BLACK_PAWN_RIGHT_CAPTURE]
             else
               [Routes::WHITE_PAWN_LEFT_CAPTURE] + [Routes::WHITE_PAWN_RIGHT_CAPTURE]
             end
    adjacent_locations = routes.map { |route| compute_position(route, spot) }

    king?(spot) && adjacent_locations.include?(location) && pawn?(location)
  end

  def king?(location) = piece(location) == :King

  def queen?(location) = piece(location) == :Queen

  def rook?(location) = piece(location) == :Rook

  def bishop?(location) = piece(location) == :Bishop

  def knight?(location) = piece(location) == :Knight

  def pawn?(location) =piece(location) == :Pawn
end
