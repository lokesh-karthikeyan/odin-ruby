# frozen_string_literal: true

# "Forsyth-Edwards Notation (FEN)" translator.
module FEN
  # Converts the given 'FEN' string to a format that can be used in this application.
  class FENResolver
    def resolve
      piece_locations, movements = piece_locations_and_movements
      active_color, castling, en_passant, half_move_clock, full_move_counter = movements.split(' ')

      piece_locations = resolve_piece_locations(piece_locations)
      movements = resolve_movements(active_color, castling, en_passant)

      movements << half_move_clock.to_i << full_move_counter.to_i

      [piece_locations, movements]
    end

    private

    attr_accessor :fen_string

    def initialize(fen_string) = self.fen_string = fen_string

    def piece_locations_and_movements
      index_of_space = fen_string.index(' ')

      piece_locations = fen_string.slice(0, index_of_space)
      movements = fen_string.slice(index_of_space + 1..)
      [piece_locations, movements]
    end

    def resolve_piece_locations(piece_locations)
      piece_locations = numbers_to_spaces(piece_locations)
      string_to_2d_array(piece_locations)
    end

    def numbers_to_spaces(piece_locations)
      loop do
        index_of_a_number = piece_locations.index(/\d/)
        return piece_locations if index_of_a_number.nil?

        string_of_spaces = ' ' * piece_locations[index_of_a_number].to_i
        piece_locations[index_of_a_number] = string_of_spaces
      end
    end

    def string_to_2d_array(piece_locations) = piece_locations.split('/').map { |row| row.split('') }

    def resolve_movements(active_color, castling, en_passant)
      current_active_color = find_active_color(active_color)

      white_king_side_castling_move = find_king_side_castling_move(castling, white: true)
      white_queen_side_castling_move = find_queen_side_castling_move(castling, white: true)

      black_king_side_castling_move = find_king_side_castling_move(castling, black: true)
      black_queen_side_castling_move = find_queen_side_castling_move(castling, black: true)

      en_passant_move = find_en_passant_move(en_passant)

      [current_active_color, white_king_side_castling_move, white_queen_side_castling_move,
       black_king_side_castling_move, black_queen_side_castling_move, en_passant_move]
    end

    def find_active_color(active_color) = active_color.eql?('w') ? :white : :black

    def find_king_side_castling_move(castling, black: false, white: false)
      return castling.include?('k') if black

      castling.include?('K') if white
    end

    def find_queen_side_castling_move(castling, black: false, white: false)
      return castling.include?('q') if black

      castling.include?('Q') if white
    end

    def find_en_passant_move(en_passant) = en_passant.include?('-') ? '' : en_passant
  end
end
