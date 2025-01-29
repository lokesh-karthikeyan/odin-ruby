# frozen_string_literal: true

require_relative '../../lib/ai/next_best_move'
require_relative '../../lib/board/board'
require_relative '../../lib/fen/fen'
require_relative '../../lib/state/state'

describe NextBestMove do
  let(:board) { Board.create }
  let(:resolved_fen_string) do
    FEN::FENResolver.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1').resolve
  end
  let(:updated_board) { Board.place_pieces(resolved_fen_string.first, board) }
  let(:moves) { resolved_fen_string.last }
  let(:movement_state) { State.create_move_state(moves) }

  describe '#determine_move' do
    context 'When the pieces are in initial position' do
      let(:next_move) { described_class.new(updated_board, movement_state) }
      subject { next_move.determine_move }
      let(:result) { [[0, 1], [2, 0]] }

      it { is_expected.to eq(result) }
    end

    context 'When there are 2 captures available with same weightage' do
      let(:next_move) { described_class.new(board, movement_state) }
      before do
        board[0][1].piece.type = :Bishop
        board[0][1].piece.color = :black

        board[1][0].piece.type = :Rook
        board[1][0].piece.color = :white
        board[6][7].piece.type = :Rook
        board[6][7].piece.color = :white
      end

      subject { next_move.determine_move }
      let(:result) { [[0, 1], [1, 0]] }

      it { is_expected.to eq(result) }
    end

    context 'When there are 2 captures, but with different weights' do
      let(:next_move) { described_class.new(board, movement_state) }
      before do
        board[2][2].piece.type = :Bishop
        board[2][2].piece.color = :black

        board[0][0].piece.type = :Rook
        board[0][0].piece.color = :white
        board[4][0].piece.type = :Queen
        board[4][0].piece.color = :white
      end

      subject { next_move.determine_move }
      let(:result) { [[2, 2], [4, 0]] }

      it { is_expected.to eq(result) }
    end

    context 'When there are 2 captures, if captured next it will be captured by white' do
      let(:next_move) { described_class.new(board, movement_state) }
      before do
        board[2][2].piece.type = :Bishop
        board[2][2].piece.color = :black

        board[0][0].piece.type = :Rook
        board[0][0].piece.color = :white
        board[4][0].piece.type = :Rook
        board[4][0].piece.color = :white
        board[1][2].piece.type = :Knight
        board[1][2].piece.color = :white
      end

      subject { next_move.determine_move }
      let(:result) { [[2, 2], [0, 0]] }

      it { is_expected.to eq(result) }
    end

    context 'When there are 2 captures, one of the capture will not be captured by white in next move' do
      let(:next_move) { described_class.new(board, movement_state) }
      before do
        board[2][2].piece.type = :Bishop
        board[2][2].piece.color = :black

        board[0][0].piece.type = :Bishop
        board[0][0].piece.color = :white
        board[4][0].piece.type = :Rook
        board[4][0].piece.color = :white
        board[1][2].piece.type = :Knight
        board[1][2].piece.color = :white
      end

      subject { next_move.determine_move }
      let(:result) { [[2, 2], [4, 0]] }

      it { is_expected.to eq(result) }
    end

    context 'When one of the capture is a "King"' do
      let(:next_move) { described_class.new(board, movement_state) }
      before do
        board[2][2].piece.type = :Bishop
        board[2][2].piece.color = :black

        board[0][0].piece.type = :King
        board[0][0].piece.color = :white
        board[4][0].piece.type = :Rook
        board[4][0].piece.color = :white
        board[1][2].piece.type = :Knight
        board[1][2].piece.color = :white
      end

      subject { next_move.determine_move }
      let(:result) { [[2, 2], [0, 0]] }

      it { is_expected.to eq(result) }
    end
  end
end
