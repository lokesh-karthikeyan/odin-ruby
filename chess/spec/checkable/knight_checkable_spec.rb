# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/checkable/knight_checkable'

describe Checkable::KnightCheckable do
  let(:board) { Board.create }

  describe '#enemy_whereabouts' do
    context 'When the King is not in "Check"' do
      before do
        board[2][2].piece.type = :King
        board[2][2].piece.color = :black
      end
      let(:position) { [2, 2] }
      let(:knight_path_inspection) { described_class.new(board, position) }

      context "without any pieces on the knight's path" do
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context "with 'Ally Knight' pieces on the knight's path" do
        before do
          board[0][3].piece.type = :Knight
          board[0][3].piece.color = :black
          board[4][1].piece.type = :Knight
          board[4][1].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context "with 'Ally Rook', 'Ally Bishop', 'Ally Queen' pieces on the knight's path" do
        before do
          board[1][4].piece.type = :Rook
          board[1][4].piece.color = :black
          board[3][0].piece.type = :Bishop
          board[3][0].piece.color = :black
          board[4][3].piece.type = :Queen
          board[4][3].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context "with 'Enemy Rook', 'Enemy Bishop', 'Enemy Queen' pieces on the knight's path" do
        before do
          board[3][4].piece.type = :Rook
          board[3][4].piece.color = :white
          board[0][1].piece.type = :Bishop
          board[0][1].piece.color = :white
          board[1][0].piece.type = :Queen
          board[1][0].piece.color = :white
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end

      context "with 'King' & 'Pawn' pieces on the knight's path" do
        before do
          board[3][4].piece.type = :King
          board[3][4].piece.color = :white
          board[0][1].piece.type = :Pawn
          board[0][1].piece.color = :white
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When the King is in "Check"' do
      before do
        board[4][5].piece.type = :King
        board[4][5].piece.color = :white
      end
      let(:position) { [4, 5] }
      let(:knight_path_inspection) { described_class.new(board, position) }

      context 'with enemy Knight on the first quadrant' do
        before do
          board[2][6].piece.type = :Knight
          board[2][6].piece.color = :black
          board[3][7].piece.type = :Knight
          board[3][7].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [[2, 6], [3, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy Knight on the second quadrant' do
        before do
          board[6][6].piece.type = :Knight
          board[6][6].piece.color = :black
          board[5][7].piece.type = :Knight
          board[5][7].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [[6, 6], [5, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy Knight on the third quadrant' do
        before do
          board[6][4].piece.type = :Knight
          board[6][4].piece.color = :black
          board[5][3].piece.type = :Knight
          board[5][3].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [[6, 4], [5, 3]] }

        it { is_expected.to match_array(result) }
      end

      context 'with enemy Knight on the fourth quadrant' do
        before do
          board[2][4].piece.type = :Knight
          board[2][4].piece.color = :black
          board[3][3].piece.type = :Knight
          board[3][3].piece.color = :black
        end
        subject { knight_path_inspection.enemy_whereabouts }
        let(:result) { [[2, 4], [3, 3]] }

        it { is_expected.to match_array(result) }
      end
    end
  end
end
