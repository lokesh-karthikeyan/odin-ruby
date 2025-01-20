# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/fen/fen'
require_relative '../../lib/fen/fen_resolver'

describe FEN do
  let(:fen_conversion) { described_class }

  describe '.generate' do
    let(:empty_board) { Board.create }

    context 'When given a board & move_state object -> "r1b1r1k1/p2p1pbp/nppB1np1/2Pq2N1/Q2P2PP/8/PP2PN2/R3KB1R w KQ - 1 17"' do # rubocop:disable Metrics/LineLength
      let(:resolved_fen_string) do
        FEN::FENResolver.new('r1b1r1k1/p2p1pbp/nppB1np1/2Pq2N1/Q2P2PP/8/PP2PN2/R3KB1R w KQ - 1 17').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { 'r1b1r1k1/p2p1pbp/nppB1np1/2Pq2N1/Q2P2PP/8/PP2PN2/R3KB1R w KQ - 1 17' }
      subject { fen_conversion.generate(updated_board, movement_state) }

      it { is_expected.to eq(result) }
    end
  end

  describe '.resolve' do
    context "When 'FEN' string -> '1rb3k1/p2p1pb1/2p3pp/q1B5/1n2N1PP/5N1B/3KP3/2QR4 w - - 2 28'" do
      let(:fen_string) { '1rb3k1/p2p1pb1/2p3pp/q1B5/1n2N1PP/5N1B/3KP3/2QR4 w - - 2 28' }
      let(:result) do
        [
          [[' ', 'r', 'b', ' ', ' ', ' ', 'k', ' '],
           ['p', ' ', ' ', 'p', ' ', 'p', 'b', ' '],
           [' ', ' ', 'p', ' ', ' ', ' ', 'p', 'p'],
           ['q', ' ', 'B', ' ', ' ', ' ', ' ', ' '],
           [' ', 'n', ' ', ' ', 'N', ' ', 'P', 'P'],
           [' ', ' ', ' ', ' ', ' ', 'N', ' ', 'B'],
           [' ', ' ', ' ', 'K', 'P', ' ', ' ', ' '],
           [' ', ' ', 'Q', 'R', ' ', ' ', ' ', ' ']],

          [:white, false, false, false, false, '', 2, 28]
        ]
      end
      subject { fen_conversion.resolve(fen_string) }

      it { is_expected.to eq(result) }
    end
  end
end
