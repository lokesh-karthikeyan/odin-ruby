# frozen_string_literal: false

# "Forsyth-Edwards Notation (FEN)" translator.
module FEN
  # Converts the board, and move state to the "FEN" formatted string.
  class FENGenerator
    def generate
      board_details = generate_fen_for_board
      movements = generate_fen_for_movements
      "#{board_details} #{movements}"
    end

    private

    attr_accessor :board, :move_state

    def initialize(board, move_state)
      self.board = board
      self.move_state = move_state
    end

    def generate_fen_for_board(output = '')
      board.length.times do |row_index|
        board.length.times do |column_index|
          piece_details = find_piece_details(row_index, column_index)
          output << fetch_fen_key(piece_details)
        end
        output << '/' if row_index < board.length - 1
      end
      format_empty_spaces(output)
    end

    def find_piece_details(row, column) = [board.dig(row, column).piece.type, board.dig(row, column).piece.color]

    def fetch_fen_key(piece_details) = fen_key[piece_details.first.to_sym][piece_details.last.to_sym]

    def format_empty_spaces(fen_output)
      loop do
        space_index = find_index_of_space(fen_output)
        break if space_index.nil?

        sub_string = fen_output.slice(space_index..)
        space_count = compute_space_count(sub_string)
        replace_spaces!(space_index, space_count, fen_output)
      end
      fen_output
    end

    def find_index_of_space(string) = string.index('_')

    def compute_space_count(string, space_count = 0)
      string.each_char do |character|
        space_count += 1 if character.eql?('_')
        break if character != '_'
      end
      space_count
    end

    def replace_spaces!(space_index, space_count, fen_output)
      fen_output.slice!(space_index, space_count)
      fen_output.insert(space_index, space_count.to_s)
    end

    def generate_fen_for_movements
      movements = "#{compute_fen_active_color} #{compute_fen_castling} #{compute_fen_en_passant}"
      move_counts = "#{fetch_half_move_clock} #{fetch_full_move_number}"
      "#{movements} #{move_counts}"
    end

    def compute_fen_active_color = move_state.active_color == :white ? 'w' : 'b'

    def compute_fen_castling
      return '-' if castling_not_allowed?

      available_castling_moves
    end

    def castling_not_allowed?
      move_state.white_king_side_castle? == false && move_state.white_queen_side_castle? == false &&
        move_state.black_king_side_castle? == false && move_state.black_queen_side_castle? == false
    end

    def available_castling_moves(result = '')
      result << 'K' if move_state.white_king_side_castle?
      result << 'Q' if move_state.white_queen_side_castle?
      result << 'k' if move_state.black_king_side_castle?
      result << 'q' if move_state.black_queen_side_castle?
      result
    end

    def compute_fen_en_passant = move_state.en_passant_target.strip.empty? ? '-' : move_state.en_passant_target

    def fetch_half_move_clock = move_state.half_move_clock.to_s

    def fetch_full_move_number = move_state.full_move_number.to_s

    def fen_key
      {
        Rook: { black: 'r', white: 'R' },
        Knight: { black: 'n', white: 'N' },
        Bishop: { black: 'b', white: 'B' },
        Queen: { black: 'q', white: 'Q' },
        King: { black: 'k', white: 'K' },
        Pawn: { black: 'p', white: 'P' },
        '': { '': '_' },
        ' ': { ' ': '_' }
      }
    end
  end
end
