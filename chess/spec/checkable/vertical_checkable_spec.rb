# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/checkable/vertical_checkable'

describe Checkable::VerticalCheckable do
  let(:board) { Board.create }

  describe '#enemy_whereabouts' do
    context 'When the King is not in "Check"' do
      before do
        board[3][1].piece.type = :King
        board[3][1].piece.color = :black
      end
      let(:position) { [3, 1] }
      let(:vertical_inspection) { described_class.new(board, position) }

      context 'without any pieces on the vertical path' do
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Ally Pawn" & "Enemy Pawn" pieces on the vertical path' do
        before do
          board[0][1].piece.type = :Pawn
          board[0][1].piece.color = :black
          board[4][1].piece.type = :Pawn
          board[4][1].piece.color = :white
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Knight" & "Bishop" pieces on the vertical path' do
        before do
          board[1][1].piece.type = :Knight
          board[1][1].piece.color = :white
          board[6][1].piece.type = :Bishop
          board[6][1].piece.color = :white
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with ally pieces of "Rook" & "Queen" on the vertical path' do
        before do
          board[2][1].piece.type = :Rook
          board[2][1].piece.color = :black
          board[7][1].piece.type = :Queen
          board[7][1].piece.color = :black
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with enemy "King" is one square space apart from this "King"' do
        before do
          board[5][1].piece.type = :King
          board[5][1].piece.color = :white
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the King is in "Check"' do
      before do
        board[3][6].piece.type = :King
        board[3][6].piece.color = :white
      end
      let(:position) { [3, 6] }
      let(:vertical_inspection) { described_class.new(board, position) }

      context 'with enemy "Rook" was on the vertical path' do
        before do
          board[7][6].piece.type = :Rook
          board[7][6].piece.color = :black
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [[7, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "Queen" was on the vertical path' do
        before do
          board[2][6].piece.type = :Queen
          board[2][6].piece.color = :black
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [[2, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "King" next to this "King"' do
        before do
          board[4][6].piece.type = :King
          board[4][6].piece.color = :black
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [[4, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with both sides are occupied by "enemy" pieces on vertical path' do
        before do
          board[1][6].piece.type = :Rook
          board[1][6].piece.color = :black
          board[6][6].piece.type = :Queen
          board[6][6].piece.color = :black
        end
        subject { vertical_inspection.enemy_whereabouts }
        let(:result) { [[1, 6], [6, 6]] }

        it { is_expected.to match_array(result) }
      end
    end
  end
end
