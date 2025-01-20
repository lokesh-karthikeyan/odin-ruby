# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/movements/pawns/black_pawn_moves'

describe BlackPawnMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the piece is in initial position -> [1, 3]' do
      let(:position) { [1, 3] }
      let(:black_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[1][3].piece.type = :Pawn
        board[1][3].piece.color = :black
      end

      context 'without any pieces on the path' do
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[2, 3], [3, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an ally piece in the diagonal box' do
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[2, 3], [3, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the diagonal box' do
        before do
          board[2][4].piece.type = :Pawn
          board[2][4].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[2, 3], [3, 3], [2, 4]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the piece is not in a initial position' do
      let(:position) { [3, 3] }
      let(:black_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][3].piece.type = :Pawn
        board[3][3].piece.color = :black
      end

      context 'with an ally piece in the diagonal box' do
        before do
          board[4][2].piece.type = :Rook
          board[4][2].piece.color = :black
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[4, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the diagonal box' do
        before do
          board[4][4].piece.type = :Bishop
          board[4][4].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[4, 3], [4, 4]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When "en passant" is available' do
      let(:movement_state) do
        double('MoveState', active_color: :black,
                            white_king_side_castle?: false, white_queen_side_castle?: false,
                            black_king_side_castle?: false, black_queen_side_castle?: false,
                            en_passant_target: 'e4', half_move_clock: 0, full_move_number: 0)
      end
      let(:position) { [4, 5] }
      let(:black_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[4][5].piece.type = :Pawn
        board[4][5].piece.color = :black
      end

      context 'with an ally piece in the adjacent box' do
        before do
          board[4][6].piece.type = :Knight
          board[4][6].piece.color = :black
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[5, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece in the adjacent box' do
        before do
          board[4][4].piece.type = :Knight
          board[4][4].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[5, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy "Pawn" in the adjacent box, but with different en passant target' do
        before do
          board[4][6].piece.type = :Pawn
          board[4][6].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[5, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy "Pawn" in the adjacent box & also with same en passant target' do
        before do
          board[4][4].piece.type = :Pawn
          board[4][4].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[5, 5], [5, 4]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the piece is blocked' do
      let(:position) { [2, 2] }
      let(:black_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[2][2].piece.type = :Pawn
        board[2][2].piece.color = :black
      end

      context 'with an enemy in the diagonal box' do
        before do
          board[3][2].piece.type = :Pawn
          board[3][2].piece.color = :white
          board[3][3].piece.type = :Pawn
          board[3][3].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [[3, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'without any enemy piece in the diagonal box' do
        before do
          board[3][2].piece.type = :Pawn
          board[3][2].piece.color = :white
        end
        subject { black_pawn_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the piece is in the last row -> [7, 4]' do
      let(:position) { [7, 4] }
      let(:black_pawn_moves) { described_class.new(board, position, movement_state) }
      before do
        board[7][4].piece.type = :Pawn
        board[7][4].piece.color = :black
      end
      subject { black_pawn_moves.legal_moves }
      let(:result) { [] }

      it { is_expected.to eq(result) }
    end
  end
end
