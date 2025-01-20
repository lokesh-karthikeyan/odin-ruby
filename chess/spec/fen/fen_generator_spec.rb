# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/fen/fen_resolver'
require_relative '../../lib/fen/fen_generator'

describe FEN::FENGenerator do
  let(:empty_board) { Board.create }
  describe '#generate' do
    context 'When no castling moves available -> "5rk1/1p4pp/pR6/8/2P1p3/4Q3/3n1PPP/1q2NK2 w - - 2 29"' do
      let(:resolved_fen_string) { FEN::FENResolver.new('5rk1/1p4pp/pR6/8/2P1p3/4Q3/3n1PPP/1q2NK2 w - - 2 29').resolve }
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { '5rk1/1p4pp/pR6/8/2P1p3/4Q3/3n1PPP/1q2NK2 w - - 2 29' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end

    context 'When all castling moves available -> "r1bqk2r/1pp2pp1/2np1n1p/p1b1p3/P1B1P2B/2PP1N2/1P3PPP/RN1QK2R b KQkq - 1 8"' do # rubocop:disable Metrics/LineLength
      let(:resolved_fen_string) do
        FEN::FENResolver.new('r1bqk2r/1pp2pp1/2np1n1p/p1b1p3/P1B1P2B/2PP1N2/1P3PPP/RN1QK2R b KQkq - 1 8').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { 'r1bqk2r/1pp2pp1/2np1n1p/p1b1p3/P1B1P2B/2PP1N2/1P3PPP/RN1QK2R b KQkq - 1 8' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end

    context 'When only the white piece castling is available -> "r1b2rk1/1pp1qp2/1bnp1n1p/pN2p1p1/P1B1P3/1QPP1NB1/1P3PPP/R3K2R w KQ - 2 13"' do # rubocop:disable Metrics/LineLength
      let(:resolved_fen_string) do
        FEN::FENResolver.new('r1b2rk1/1pp1qp2/1bnp1n1p/pN2p1p1/P1B1P3/1QPP1NB1/1P3PPP/R3K2R w KQ - 2 13').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { 'r1b2rk1/1pp1qp2/1bnp1n1p/pN2p1p1/P1B1P3/1QPP1NB1/1P3PPP/R3K2R w KQ - 2 13' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end

    context 'When only the black piece castling is available -> "r1bqk2r/p2p1ppp/2p2n2/4p3/1bP1P3/2NB4/PP3PPP/R1BQ1RK1 b kq - 1 9"' do # rubocop:disable Metrics/LineLength
      let(:resolved_fen_string) do
        FEN::FENResolver.new('r1bqk2r/p2p1ppp/2p2n2/4p3/1bP1P3/2NB4/PP3PPP/R1BQ1RK1 b kq - 1 9').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { 'r1bqk2r/p2p1ppp/2p2n2/4p3/1bP1P3/2NB4/PP3PPP/R1BQ1RK1 b kq - 1 9' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end

    context 'When en passant is available -> "rnbqkb1r/ppp2ppp/3p4/8/3Pn3/5N2/PPP2PPP/RNBQKB1R b KQkq d3 0 5"' do
      let(:resolved_fen_string) do
        FEN::FENResolver.new('rnbqkb1r/ppp2ppp/3p4/8/3Pn3/5N2/PPP2PPP/RNBQKB1R b KQkq d3 0 5').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { 'rnbqkb1r/ppp2ppp/3p4/8/3Pn3/5N2/PPP2PPP/RNBQKB1R b KQkq d3 0 5' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end

    context 'When no pieces are available -> "8/8/8/8/8/8/8/8 w KQkq - 0 0"' do
      let(:resolved_fen_string) do
        FEN::FENResolver.new('8/8/8/8/8/8/8/8 w KQkq - 0 0').resolve
      end
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, empty_board) }
      let(:moves) { resolved_fen_string.last }
      let(:movement_state) do
        double('MoveState', active_color: moves[0],
                            white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                            black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                            en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
      end
      let(:result) { '8/8/8/8/8/8/8/8 w KQkq - 0 0' }
      subject { described_class.new(updated_board, movement_state).generate }

      it { is_expected.to eq(result) }
    end
  end
end
