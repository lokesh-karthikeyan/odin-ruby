# frozen_string_literal: true

require_relative '../../lib/ai/position_evaluation'
require_relative '../../lib/board/board'
require_relative '../../lib/fen/fen'

describe PositionEvaluation do
  let(:board) { Board.create }

  describe '#compute_weight' do
    let(:resolved_fen_string) do
      FEN::FENResolver.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1').resolve
    end
    let(:updated_board) { Board.place_pieces(resolved_fen_string.first, board) }

    context 'When the color -> "White"' do
      let(:position_evaluator) { described_class.new(updated_board) }
      let(:color) { :white }

      context 'with the board state is in initial position' do
        subject { position_evaluator.compute_weight(color) }

        it { is_expected.to be_zero }
      end

      context 'with having a 1 -> white bishop, & 1 -> black bishop & black knight & black rook' do
        let(:position_evaluator) { described_class.new(board) }

        before do
          board[7][1].piece.type = :Bishop
          board[7][1].piece.color = :white

          board[6][0].piece.type = :Knight
          board[6][0].piece.color = :black
          board[6][2].piece.type = :Bishop
          board[6][2].piece.color = :black
          board[5][0].piece.type = :Rook
          board[5][0].piece.color = :black
        end

        subject { position_evaluator.compute_weight(color) }

        it { is_expected.to eq(-80) }
      end
    end

    context 'When the color -> "Black"' do
      let(:position_evaluator) { described_class.new(updated_board) }
      let(:color) { :black }

      context 'with the board state is in initial position' do
        subject { position_evaluator.compute_weight(color) }

        it { is_expected.to be_zero }
      end

      context 'with having a 1 -> black bishop, & 1 -> white bishop & white knight & black rook' do
        let(:position_evaluator) { described_class.new(board) }

        before do
          board[7][1].piece.type = :Bishop
          board[7][1].piece.color = :white

          board[6][0].piece.type = :Knight
          board[6][0].piece.color = :black
          board[6][2].piece.type = :Bishop
          board[6][2].piece.color = :black
          board[5][0].piece.type = :Rook
          board[5][0].piece.color = :black
        end

        subject { position_evaluator.compute_weight(color) }

        it { is_expected.to eq(80) }
      end
    end
  end
end
