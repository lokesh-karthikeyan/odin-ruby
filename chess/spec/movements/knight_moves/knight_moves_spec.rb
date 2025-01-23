# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/movements/knight_moves/knight_moves'

describe KnightMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the Knight was not blocked by any piece & the position -> [3, 4]' do
      let(:position) { [3, 4] }
      let(:knight_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][4].piece.type = :Knight
        board[3][4].piece.color = :black
      end

      subject { knight_moves.legal_moves }
      let(:result) { [[1, 5], [2, 6], [5, 5], [4, 6], [5, 3], [4, 2], [1, 3], [2, 2]] }

      it { is_expected.to match_array(result) }
    end

    context 'When the Knight was blocked & the position -> [1, 6]' do
      let(:position) { [1, 6] }
      let(:knight_moves) { described_class.new(board, position, movement_state) }
      before do
        board[1][6].piece.type = :Knight
        board[1][6].piece.color = :black
      end

      context 'with an ally piece at [2, 4]' do
        before do
          board[2][4].piece.type = :King
          board[2][4].piece.color = :black
        end

        subject { knight_moves.legal_moves }
        let(:result) { [[3, 7], [3, 5], [0, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece at [0, 4]' do
        before do
          board[0][4].piece.type = :Queen
          board[0][4].piece.color = :white
        end

        subject { knight_moves.legal_moves }
        let(:result) { [[3, 7], [3, 5], [2, 4], [0, 4]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the Knight was at corner spot -> [0, 7]' do
      let(:position) { [0, 7] }
      let(:knight_moves) { described_class.new(board, position, movement_state) }
      before do
        board[0][7].piece.type = :Knight
        board[0][7].piece.color = :white
      end

      context 'with being blocked by an "enemy piece"' do
        before do
          board[2][6].piece.type = :Queen
          board[2][6].piece.color = :black
          board[1][5].piece.type = :Rook
          board[1][5].piece.color = :black
        end

        subject { knight_moves.legal_moves }
        let(:result) { [[2, 6], [1, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with being blocked by an "ally piece"' do
        before do
          board[2][6].piece.type = :Queen
          board[2][6].piece.color = :white
          board[1][5].piece.type = :Rook
          board[1][5].piece.color = :white
        end

        subject { knight_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end
  end
end
