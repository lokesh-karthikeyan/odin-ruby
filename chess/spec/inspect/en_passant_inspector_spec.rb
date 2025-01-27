# frozen_string_literal: true

require_relative '../../lib/inspect/en_passant_inspector'
require_relative '../../lib/board/board'

describe EnPassantInspector do
  let(:board) { Board.create }

  describe '#en_passant?' do
    let(:inspector) { described_class.new(board) }

    context 'When the "En Passant" is not allowed' do
      context 'with the "Pawn" just made a single step' do
        context 'with the piece color -> "Black"' do
          before do
            board[2][4].piece.type = :Pawn
            board[2][4].piece.color = :black
          end
          let(:source) { [1, 4] }
          let(:target) { [2, 4] }

          subject { inspector.en_passant?(source, target) }

          it { is_expected.not_to be true }
        end

        context 'with the piece color -> "White"' do
          before do
            board[5][6].piece.type = :Pawn
            board[5][6].piece.color = :white
          end
          let(:source) { [6, 6] }
          let(:target) { [5, 6] }

          subject { inspector.en_passant?(source, target) }

          it { is_expected.not_to be true }
        end
      end

      context 'with the piece was not a "Pawn"' do
        before do
          board[4][3].piece.type = :Rook
          board[4][3].piece.color = :white
        end
        let(:source) { [6, 3] }
        let(:target) { [4, 3] }

        subject { inspector.en_passant?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with an unqualified source spot' do
        context 'with the piece color -> "Black"' do
          before do
            board[3][6].piece.type = :Pawn
            board[3][6].piece.color = :black
          end
          let(:source) { [2, 7] }
          let(:target) { [3, 6] }

          subject { inspector.en_passant?(source, target) }

          it { is_expected.not_to be true }
        end

        context 'with the piece color -> "White"' do
          before do
            board[2][3].piece.type = :Pawn
            board[2][3].piece.color = :white
          end
          let(:source) { [3, 3] }
          let(:target) { [2, 3] }

          subject { inspector.en_passant?(source, target) }

          it { is_expected.not_to be true }
        end
      end
    end

    context 'When the "En Passant" is allowed' do
      context 'with the piece color -> "Black"' do
        before do
          board[3][7].piece.type = :Pawn
          board[3][7].piece.color = :black
        end
        let(:source) { [1, 7] }
        let(:target) { [3, 7] }

        subject { inspector.en_passant?(source, target) }

        it { is_expected.to be true }
      end

      context 'with the piece color -> "White"' do
        before do
          board[4][0].piece.type = :Pawn
          board[4][0].piece.color = :white
        end
        let(:source) { [6, 0] }
        let(:target) { [4, 0] }

        subject { inspector.en_passant?(source, target) }

        it { is_expected.to be true }
      end
    end
  end
end
