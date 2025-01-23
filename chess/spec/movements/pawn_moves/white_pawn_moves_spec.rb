# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/movements/pawn_moves/white_pawn_moves'

describe WhitePawnMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :white,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the piece is in initial position -> [6, 2]' do
      let(:position) { [6, 2] }
      let(:white_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[6][2].piece.type = :Pawn
        board[6][2].piece.color = :white
      end

      context 'without any pieces on the path' do
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[5, 2], [4, 2]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an ally piece in the diagonal box' do
        before do
          board[5][3].piece.type = :Pawn
          board[5][3].piece.color = :white
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[5, 2], [4, 2]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the diagonal box' do
        before do
          board[5][1].piece.type = :Queen
          board[5][1].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[5, 2], [4, 2], [5, 1]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the piece is not in a initial position' do
      let(:position) { [4, 4] }
      let(:white_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[4][4].piece.type = :Pawn
        board[4][4].piece.color = :white
      end

      context 'with an ally piece in the diagonal box' do
        before do
          board[3][5].piece.type = :Rook
          board[3][5].piece.color = :white
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[3, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the diagonal box' do
        before do
          board[3][3].piece.type = :Bishop
          board[3][3].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[3, 4], [3, 3]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When "en passant" is available' do
      let(:movement_state) do
        double('MoveState', active_color: :white,
                            white_king_side_castle?: false, white_queen_side_castle?: false,
                            black_king_side_castle?: false, black_queen_side_castle?: false,
                            en_passant_target: 'c5', half_move_clock: 0, full_move_number: 0)
      end
      let(:position) { [3, 3] }
      let(:white_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][3].piece.type = :Pawn
        board[3][3].piece.color = :white
      end

      context 'with an ally piece in the adjacent box' do
        before do
          board[3][4].piece.type = :Knight
          board[3][4].piece.color = :white
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[2, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the adjacent box' do
        before do
          board[3][2].piece.type = :Knight
          board[3][2].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[2, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy "Pawn" in the adjacent box, but with different en passant target' do
        before do
          board[3][4].piece.type = :Pawn
          board[3][4].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[2, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy "Pawn" in the adjacent box & also with same en passant target' do
        before do
          board[3][2].piece.type = :Pawn
          board[3][2].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[2, 3], [2, 2]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the piece is blocked' do
      let(:position) { [3, 5] }
      let(:white_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][5].piece.type = :Pawn
        board[3][5].piece.color = :white
      end

      context 'with an enemy in the diagonal box' do
        before do
          board[2][5].piece.type = :Pawn
          board[2][5].piece.color = :black
          board[2][4].piece.type = :Pawn
          board[2][4].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [[2, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'without any enemy piece in the diagonal box' do
        before do
          board[2][5].piece.type = :Pawn
          board[2][5].piece.color = :black
        end
        subject { white_pawn_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the piece is in the last row -> [0, 2]' do
      let(:position) { [0, 2] }
      let(:white_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[0][2].piece.type = :Pawn
        board[0][2].piece.color = :white
      end
      subject { white_pawn_moves.legal_moves }
      let(:result) { [] }

      it { is_expected.to eq(result) }
    end
  end
end
