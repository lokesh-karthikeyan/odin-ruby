# frozen_string_literal: true

require_relative '../../lib/inspect/pawn_promotion_inspector'
require_relative '../../lib/board/board'

describe PawnPromotionInspector do
  let(:board) { Board.create }
  let(:inspector) { described_class.new(board) }

  describe '#pawn_promotion?' do
    context 'When there is no pawn promotion' do
      context 'with the promotion dismissal is due to target row' do
        before do
          board[4][3].piece.type = :Pawn
          board[4][3].piece.color = :white
        end
        let(:target) { [4, 3] }
        let(:color) { :white }

        subject { inspector.pawn_promotion?(target, color) }

        it { is_expected.not_to be true }
      end

      context 'with the promotion dismissal is due to piece type' do
        before do
          board[7][3].piece.type = :Queen
          board[7][3].piece.color = :white
        end
        let(:target) { [7, 3] }
        let(:color) { :white }

        subject { inspector.pawn_promotion?(target, color) }

        it { is_expected.not_to be true }
      end

      context 'with the promotion dismissal is due to both target row & piece type' do
        before do
          board[4][3].piece.type = :Bishop
          board[4][3].piece.color = :black
        end
        let(:target) { [4, 3] }
        let(:color) { :black }

        subject { inspector.pawn_promotion?(target, color) }

        it { is_expected.not_to be true }
      end
    end

    context 'When there is a pawn promotion' do
      context 'with the piece color == "Black"' do
        before do
          board[7][5].piece.type = :Pawn
          board[7][5].piece.color = :black
        end
        let(:target) { [7, 5] }
        let(:color) { :black }

        subject { inspector.pawn_promotion?(target, color) }

        it { is_expected.to be true }
      end

      context 'with the piece color == "White"' do
        before do
          board[0][7].piece.type = :Pawn
          board[0][7].piece.color = :white
        end
        let(:target) { [0, 7] }
        let(:color) { :white }

        subject { inspector.pawn_promotion?(target, color) }

        it { is_expected.to be true }
      end
    end
  end
end
