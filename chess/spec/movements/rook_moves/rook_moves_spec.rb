# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/movements/rook_moves'

describe RookMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the Rook was not blocked by any piece & the position -> [3, 3]' do
      let(:position) { [3, 3] }
      let(:rook_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][3].piece.type = :Rook
        board[3][3].piece.color = :black
      end

      subject { rook_moves.legal_moves }
      let(:result) do
        [[3, 2], [3, 1], [3, 0], [2, 3], [1, 3], [0, 3], [3, 4], [3, 5], [3, 6], [3, 7], [4, 3], [5, 3], [6, 3], [7, 3]]
      end

      it { is_expected.to match_array(result) }
    end

    context 'When the Rook was blocked & the position -> [3, 3]' do
      let(:position) { [3, 3] }
      let(:rook_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][3].piece.type = :Rook
        board[3][3].piece.color = :black
      end

      context 'with an ally piece at [3, 4]' do
        before do
          board[3][4].piece.type = :Rook
          board[3][4].piece.color = :black
        end

        subject { rook_moves.legal_moves }
        let(:result) do
          [[3, 2], [3, 1], [3, 0], [2, 3], [1, 3], [0, 3], [4, 3], [5, 3], [6, 3], [7, 3]]
        end

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece at [4, 3]' do
        before do
          board[4][3].piece.type = :Knight
          board[4][3].piece.color = :white
        end

        subject { rook_moves.legal_moves }
        let(:result) do
          [[3, 2], [3, 1], [3, 0], [2, 3], [1, 3], [0, 3], [3, 4], [3, 5], [3, 6], [3, 7], [4, 3]]
        end

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the Rook was at corner spot -> [0, 0]' do
      let(:position) { [0, 0] }
      let(:rook_moves) { described_class.new(board, position, movement_state) }
      before do
        board[0][0].piece.type = :Rook
        board[0][0].piece.color = :white
      end

      context 'with being blocked by an "enemy piece"' do
        before do
          board[1][0].piece.type = :Knight
          board[1][0].piece.color = :black
        end

        subject { rook_moves.legal_moves }
        let(:result) { [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0]] }

        it { is_expected.to match_array(result) }
      end

      context 'with being blocked by an "ally piece"' do
        before do
          board[1][0].piece.type = :Pawn
          board[1][0].piece.color = :white
          board[0][1].piece.type = :Knight
          board[0][1].piece.color = :white
        end

        subject { rook_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end
  end
end
