# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/movements/queen_moves'

describe QueenMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the Queen was not blocked by any piece & the position -> [2, 2]' do
      let(:position) { [2, 2] }
      let(:queen_moves) { described_class.new(board, position, movement_state) }
      before do
        board[2][2].piece.type = :Queen
        board[2][2].piece.color = :black
      end

      subject { queen_moves.legal_moves }
      let(:result) do
        [[2, 1], [2, 0], [1, 1], [0, 0], [1, 2], [0, 2], [1, 3], [0, 4], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
         [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [3, 1], [4, 0]]
      end

      it { is_expected.to match_array(result) }
    end

    context 'When the Queen was blocked & the position -> [5, 5]' do
      let(:position) { [5, 5] }
      let(:queen_moves) { described_class.new(board, position, movement_state) }
      before do
        board[5][5].piece.type = :Queen
        board[5][5].piece.color = :black
      end

      context 'with an ally piece at [5, 6]' do
        before do
          board[5][6].piece.type = :Bishop
          board[5][6].piece.color = :black
        end

        subject { queen_moves.legal_moves }
        let(:result) do
          [[5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0], [4, 5], [3, 5],
           [2, 5], [1, 5], [0, 5], [4, 6], [3, 7], [6, 6], [7, 7], [6, 5], [7, 5], [6, 4], [7, 3]]
        end

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece at [4, 4]' do
        before do
          board[4][4].piece.type = :Rook
          board[4][4].piece.color = :white
        end

        subject { queen_moves.legal_moves }
        let(:result) do
          [[5, 4], [5, 3], [5, 2], [5, 1], [5, 0], [4, 4], [4, 5], [3, 5], [2, 5], [1, 5], [0, 5],
           [4, 6], [3, 7], [5, 6], [5, 7], [6, 6], [7, 7], [6, 5], [7, 5], [6, 4], [7, 3]]
        end

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the Queen was at corner spot -> [7, 0]' do
      let(:position) { [7, 0] }
      let(:queen_moves) { described_class.new(board, position, movement_state) }
      before do
        board[7][0].piece.type = :Queen
        board[7][0].piece.color = :white
      end

      context 'with being blocked by an "enemy piece"' do
        before do
          board[6][0].piece.type = :Rook
          board[6][0].piece.color = :black
          board[6][1].piece.type = :Pawn
          board[6][1].piece.color = :black
          board[7][1].piece.type = :Knight
          board[7][1].piece.color = :black
        end

        subject { queen_moves.legal_moves }
        let(:result) { [[6, 0], [6, 1], [7, 1]] }

        it { is_expected.to match_array(result) }
      end

      context 'with being blocked by an "ally piece"' do
        before do
          board[6][0].piece.type = :Rook
          board[6][0].piece.color = :white
          board[6][1].piece.type = :Pawn
          board[6][1].piece.color = :white
          board[7][1].piece.type = :Knight
          board[7][1].piece.color = :white
        end

        subject { queen_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end
  end
end
