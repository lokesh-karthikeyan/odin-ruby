# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/checkable/diagonal_checkable'

describe Checkable::DiagonalCheckable do
  let(:board) { Board.create }

  describe '#enemy_whereabouts' do
    context 'When the King is not in "Check"' do
      before do
        board[4][3].piece.type = :King
        board[4][3].piece.color = :black
      end
      let(:position) { [4, 3] }
      let(:diagonal_inspection) { described_class.new(board, position) }

      context 'without any pieces on the diagonal path' do
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Ally Rook" & "Enemy Rook" pieces on the diagonal path' do
        before do
          board[7][0].piece.type = :Rook
          board[7][0].piece.color = :black
          board[5][4].piece.type = :Rook
          board[5][4].piece.color = :white
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Ally Knight" & "Enemy Knight" pieces on the diagonal path' do
        before do
          board[1][0].piece.type = :Knight
          board[1][0].piece.color = :black
          board[3][4].piece.type = :Knight
          board[3][4].piece.color = :white
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with ally pieces of "Bishop", "Pawn", "Queen" on the diagonal path' do
        before do
          board[2][1].piece.type = :Bishop
          board[2][1].piece.color = :black
          board[0][7].piece.type = :Queen
          board[0][7].piece.color = :black
          board[5][2].piece.type = :Pawn
          board[5][2].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with enemy "King" & "Pawn" is one square space apart from this "King"' do
        before do
          board[2][5].piece.type = :King
          board[2][5].piece.color = :white
          board[6][5].piece.type = :Pawn
          board[6][5].piece.color = :white
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with enemy "Pawn" is nearby, but the "Pawn" is unable to move backward & the "King" is "White" piece' do
        before do
          board[3][2].piece.type = :Pawn
          board[3][2].piece.color = :white
          board[3][4].piece.type = :Pawn
          board[3][4].piece.color = :white
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with enemy "Pawn" is nearby, but the "Pawn" is unable to move backward & the "King" is "Black" piece' do
        before do
          board[4][3].piece.color = :white
          board[5][2].piece.type = :Pawn
          board[5][2].piece.color = :black
          board[5][4].piece.type = :Pawn
          board[5][4].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the King is in "Check"' do
      before do
        board[5][5].piece.type = :King
        board[5][5].piece.color = :white
      end
      let(:position) { [5, 5] }
      let(:diagonal_inspection) { described_class.new(board, position) }

      context 'with enemy "Pawn" was on the diagonal path & the "King" is "White" piece' do
        before do
          board[4][4].piece.type = :Pawn
          board[4][4].piece.color = :black
          board[6][6].piece.type = :Pawn
          board[6][6].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[4, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "Pawn" was on the diagonal path & the "King" is "Black" piece' do
        before do
          board[5][5].piece.color = :black
          board[6][4].piece.type = :Pawn
          board[6][4].piece.color = :white
          board[4][6].piece.type = :Pawn
          board[4][6].piece.color = :white
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[6, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "Bishop" was on the diagonal path' do
        before do
          board[3][7].piece.type = :Bishop
          board[3][7].piece.color = :black
          board[7][3].piece.type = :Bishop
          board[7][3].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[3, 7], [7, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "Queen" was on the diagonal path' do
        before do
          board[0][0].piece.type = :Queen
          board[0][0].piece.color = :black
          board[7][7].piece.type = :Queen
          board[7][7].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[0, 0], [7, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "King" next to this "King"' do
        before do
          board[4][4].piece.type = :King
          board[4][4].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[4, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with all sides are occupied by "enemy" pieces on diagonal path' do
        before do
          board[4][4].piece.type = :Pawn
          board[4][4].piece.color = :black
          board[3][7].piece.type = :Bishop
          board[3][7].piece.color = :black
          board[7][3].piece.type = :Queen
          board[7][3].piece.color = :black
          board[7][7].piece.type = :Bishop
          board[7][7].piece.color = :black
        end
        subject { diagonal_inspection.enemy_whereabouts }
        let(:result) { [[4, 4], [3, 7], [7, 3], [7, 7]] }

        it { is_expected.to match_array(result) }
      end
    end
  end
end
