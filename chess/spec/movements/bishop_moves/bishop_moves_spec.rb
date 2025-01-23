# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/movements/bishop_moves/bishop_moves'

describe BishopMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the Bishop was not blocked by any piece & the position -> [4, 4]' do
      let(:position) { [4, 4] }
      let(:bishop_moves) { described_class.new(board, position, movement_state) }
      before do
        board[4][4].piece.type = :Bishop
        board[4][4].piece.color = :black
      end

      subject { bishop_moves.legal_moves }
      let(:result) do
        [[3, 3], [2, 2], [1, 1], [0, 0], [3, 5], [2, 6], [1, 7], [5, 3], [6, 2], [7, 1], [5, 5], [6, 6], [7, 7]]
      end

      it { is_expected.to match_array(result) }
    end

    context 'When the Bishop was blocked & the position -> [3, 3]' do
      let(:position) { [3, 3] }
      let(:bishop_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][3].piece.type = :Bishop
        board[3][3].piece.color = :black
      end

      context 'with an ally piece at [2, 4]' do
        before do
          board[2][4].piece.type = :Pawn
          board[2][4].piece.color = :black
        end
        subject { bishop_moves.legal_moves }
        let(:result) do
          [[2, 2], [1, 1], [0, 0], [4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [6, 6], [7, 7]]
        end

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece at [4, 2]' do
        before do
          board[4][2].piece.type = :Queen
          board[4][2].piece.color = :white
        end
        subject { bishop_moves.legal_moves }
        let(:result) do
          [[2, 2], [1, 1], [0, 0], [2, 4], [1, 5], [0, 6], [4, 2], [4, 4], [5, 5], [6, 6], [7, 7]]
        end

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the Bishop was at corner spot -> [7, 7]' do
      let(:position) { [7, 7] }
      let(:bishop_moves) { described_class.new(board, position, movement_state) }
      before do
        board[7][7].piece.type = :Bishop
        board[7][7].piece.color = :white
      end

      context 'with being blocked by an "enemy piece"' do
        before do
          board[6][6].piece.type = :Rook
          board[6][6].piece.color = :black
        end
        subject { bishop_moves.legal_moves }
        let(:result) { [[6, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with being blocked by an "ally piece"' do
        before do
          board[6][6].piece.type = :Rook
          board[6][6].piece.color = :white
        end
        subject { bishop_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end
  end
end
