# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/checkable/horizontal_checkable'

describe Checkable::HorizontalCheckable do
  let(:board) { Board.create }

  describe '#enemy_whereabouts' do
    context 'When the King is not in "Check"' do
      before do
        board[5][3].piece.type = :King
        board[5][3].piece.color = :black
      end
      let(:position) { [5, 3] }
      let(:horizontal_inspection) { described_class.new(board, position) }

      context 'without any pieces on the horizontal path' do
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Ally Pawn" & "Enemy Pawn" pieces on the horizontal path' do
        before do
          board[5][2].piece.type = :Pawn
          board[5][2].piece.color = :black
          board[5][4].piece.type = :Pawn
          board[5][4].piece.color = :white
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with "Knight" & "Bishop" pieces on the horizontal path' do
        before do
          board[5][0].piece.type = :Knight
          board[5][0].piece.color = :white
          board[5][7].piece.type = :Bishop
          board[5][7].piece.color = :white
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with ally pieces of "Rook" & "Queen" on the horizontal path' do
        before do
          board[5][0].piece.type = :Rook
          board[5][0].piece.color = :black
          board[5][7].piece.type = :Queen
          board[5][7].piece.color = :black
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context 'with enemy "King" is one square space apart from this "King"' do
        before do
          board[5][1].piece.type = :King
          board[5][1].piece.color = :white
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the King is in "Check"' do
      before do
        board[0][4].piece.type = :King
        board[0][4].piece.color = :white
      end
      let(:position) { [0, 4] }
      let(:horizontal_inspection) { described_class.new(board, position) }

      context 'with enemy "Rook" was on the horizontal path' do
        before do
          board[0][0].piece.type = :Rook
          board[0][0].piece.color = :black
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [[0, 0]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "Queen" was on the horizontal path' do
        before do
          board[0][5].piece.type = :Queen
          board[0][5].piece.color = :black
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [[0, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy "King" next to this "King"' do
        before do
          board[0][3].piece.type = :King
          board[0][3].piece.color = :black
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [[0, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with both sides are occupied by "enemy" pieces on horizontal path' do
        before do
          board[0][3].piece.type = :King
          board[0][3].piece.color = :black
          board[0][7].piece.type = :Queen
          board[0][7].piece.color = :black
        end
        subject { horizontal_inspection.enemy_whereabouts }
        let(:result) { [[0, 3], [0, 7]] }

        it { is_expected.to match_array(result) }
      end
    end
  end
end
