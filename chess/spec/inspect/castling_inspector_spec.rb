# frozen_string_literal: true

require_relative '../../lib/inspect/castling_inspector'
require_relative '../../lib/board/board'

describe CastlingInspector do
  let(:board) { Board.create }
  let(:inspector) { described_class.new(board) }

  describe '#castling?' do
    context 'When "Castling" is not allowed' do
      context 'When the source == [0, 4] && target == [0, 6] && piece == "King" && color == "White"' do
        before do
          board[0][6].piece.type = :King
          board[0][6].piece.color = :white
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 6] }

        subject { inspector.castling?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'When the source == [7, 4] && target == [7, 2] && piece == "King" && color == "Black"' do
        before do
          board[7][2].piece.type = :King
          board[7][2].piece.color = :black
        end
        let(:source) { [7, 4] }
        let(:target) { [7, 2] }

        subject { inspector.castling?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'When the source == [0, 4] && target == [0, 6] && piece == "Queen" && color == "Black"' do
        before do
          board[0][6].piece.type = :Queen
          board[0][6].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 6] }

        subject { inspector.castling?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'When the source == [0, 4] && target == [0, 3] && piece == "King" && color == "Black"' do
        before do
          board[0][3].piece.type = :King
          board[0][3].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 3] }

        subject { inspector.castling?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'When the source == [7, 3] && target == [7, 2] && piece == "King" && color == "White"' do
        before do
          board[7][2].piece.type = :King
          board[7][2].piece.color = :white
        end
        let(:source) { [7, 3] }
        let(:target) { [7, 2] }

        subject { inspector.castling?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When "Castling" is allowed' do
      context 'When the source == [0, 4] && target == [0, 2] && piece == "King" && color == "Black"' do
        before do
          board[0][2].piece.type = :King
          board[0][2].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 2] }

        subject { inspector.castling?(source, target) }

        it { is_expected.to be true }
      end

      context 'When the source == [7, 4] && target == [7, 2] && piece == "King" && color == "White"' do
        before do
          board[7][2].piece.type = :King
          board[7][2].piece.color = :white
        end
        let(:source) { [7, 4] }
        let(:target) { [7, 2] }

        subject { inspector.castling?(source, target) }

        it { is_expected.to be true }
      end

      context 'When the source == [0, 4] && target == [0, 6] && piece == "King" && color == "Black"' do
        before do
          board[0][6].piece.type = :King
          board[0][6].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 6] }

        subject { inspector.castling?(source, target) }

        it { is_expected.to be true }
      end

      context 'When the source == [7, 4] && target == [7, 6] && piece == "King" && color == "White"' do
        before do
          board[7][6].piece.type = :King
          board[7][6].piece.color = :white
        end
        let(:source) { [7, 4] }
        let(:target) { [7, 6] }

        subject { inspector.castling?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#black_king_moved?' do
    context 'When the "King" is not moved' do
      context 'with the source == [0, 4], but the piece is a different piece' do
        before do
          board[3][7].piece.type = :Bishop
          board[3][7].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [3, 7] }

        subject { inspector.black_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [0, 4], but the piece is an enemy "King"' do
        before do
          board[1][3].piece.type = :King
          board[1][3].piece.color = :white
        end
        let(:source) { [0, 4] }
        let(:target) { [1, 3] }

        subject { inspector.black_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "King" but the source is different' do
        before do
          board[0][6].piece.type = :King
          board[0][6].piece.color = :black
        end
        let(:source) { [0, 5] }
        let(:target) { [0, 6] }

        subject { inspector.black_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When the "King" was moved' do
      context 'with the source == [0, 4] && piece == "King"' do
        before do
          board[0][2].piece.type = :King
          board[0][2].piece.color = :black
        end
        let(:source) { [0, 4] }
        let(:target) { [0, 2] }

        subject { inspector.black_king_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#white_king_moved?' do
    context 'When the "King" is not moved' do
      context 'with the source == [7, 4], but the piece is a different piece' do
        before do
          board[4][7].piece.type = :Bishop
          board[4][7].piece.color = :white
        end
        let(:source) { [7, 4] }
        let(:target) { [4, 7] }

        subject { inspector.white_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [7, 4], but the piece is an enemy "King"' do
        before do
          board[7][5].piece.type = :King
          board[7][5].piece.color = :black
        end
        let(:source) { [7, 4] }
        let(:target) { [7, 5] }

        subject { inspector.white_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "King" but the source is different' do
        before do
          board[7][2].piece.type = :King
          board[7][2].piece.color = :white
        end
        let(:source) { [7, 3] }
        let(:target) { [7, 2] }

        subject { inspector.white_king_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When the "King" was moved' do
      context 'with the source == [7, 4] && piece == "King"' do
        before do
          board[6][5].piece.type = :King
          board[6][5].piece.color = :white
        end
        let(:source) { [7, 4] }
        let(:target) { [6, 5] }

        subject { inspector.white_king_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#left_black_rook_moved?' do
    context 'When "Rook" movement is not detected' do
      context 'with the source == [0, 0], but the piece is different' do
        before do
          board[7][7].piece.type = :Queen
          board[7][7].piece.color = :black
        end
        let(:source) { [0, 0] }
        let(:target) { [7, 7] }

        subject { inspector.left_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [0, 0], but the piece is an enemy "Rook"' do
        before do
          board[0][7].piece.type = :Rook
          board[0][7].piece.color = :white
        end
        let(:source) { [0, 0] }
        let(:target) { [0, 7] }

        subject { inspector.left_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "Rook", but the source is different' do
        before do
          board[1][7].piece.type = :Rook
          board[1][7].piece.color = :black
        end
        let(:source) { [1, 0] }
        let(:target) { [1, 7] }

        subject { inspector.left_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When "Rook" movement is detected' do
      context 'with the source == [0, 0] && the piece == "Rook"' do
        before do
          board[0][5].piece.type = :Rook
          board[0][5].piece.color = :black
        end
        let(:source) { [0, 0] }
        let(:target) { [0, 5] }

        subject { inspector.left_black_rook_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#right_black_rook_moved?' do
    context 'When "Rook" movement is not detected' do
      context 'with the source == [0, 7], but the piece is different' do
        before do
          board[1][5].piece.type = :Knight
          board[1][5].piece.color = :black
        end
        let(:source) { [0, 7] }
        let(:target) { [1, 5] }

        subject { inspector.right_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [0, 7], but the piece is an enemy "Rook"' do
        before do
          board[0][2].piece.type = :Rook
          board[0][2].piece.color = :white
        end
        let(:source) { [0, 7] }
        let(:target) { [0, 2] }

        subject { inspector.right_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "Rook", but the source is different' do
        before do
          board[0][0].piece.type = :Rook
          board[0][0].piece.color = :black
        end
        let(:source) { [0, 6] }
        let(:target) { [0, 0] }

        subject { inspector.right_black_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When "Rook" movement is detected' do
      context 'with the source == [0, 7] && the piece == "Rook"' do
        before do
          board[7][7].piece.type = :Rook
          board[7][7].piece.color = :black
        end
        let(:source) { [0, 7] }
        let(:target) { [7, 7] }

        subject { inspector.right_black_rook_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#left_white_rook_moved?' do
    context 'When "Rook" movement is not detected' do
      context 'with the source == [7, 0], but the piece is different' do
        before do
          board[5][2].piece.type = :Bishop
          board[5][2].piece.color = :white
        end
        let(:source) { [7, 0] }
        let(:target) { [5, 2] }

        subject { inspector.left_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [7, 0], but the piece is an enemy "Rook"' do
        before do
          board[5][0].piece.type = :Rook
          board[5][0].piece.color = :black
        end
        let(:source) { [7, 0] }
        let(:target) { [5, 0] }

        subject { inspector.left_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "Rook", but the source is different' do
        before do
          board[1][1].piece.type = :Rook
          board[1][1].piece.color = :white
        end
        let(:source) { [7, 1] }
        let(:target) { [1, 1] }

        subject { inspector.left_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When "Rook" movement is detected' do
      context 'with the source == [7, 0] && the piece == "Rook"' do
        before do
          board[7][7].piece.type = :Rook
          board[7][7].piece.color = :white
        end
        let(:source) { [7, 0] }
        let(:target) { [7, 7] }

        subject { inspector.left_white_rook_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#right_white_rook_moved?' do
    context 'When "Rook" movement is not detected' do
      context 'with the source == [7, 7], but the piece is different' do
        before do
          board[6][7].piece.type = :King
          board[6][7].piece.color = :white
        end
        let(:source) { [7, 7] }
        let(:target) { [6, 7] }

        subject { inspector.right_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the source == [7, 7], but the piece is an enemy "Rook"' do
        before do
          board[3][7].piece.type = :Rook
          board[3][7].piece.color = :black
        end
        let(:source) { [7, 7] }
        let(:target) { [3, 7] }

        subject { inspector.right_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end

      context 'with the piece == "Rook", but the source is different' do
        before do
          board[0][6].piece.type = :Rook
          board[0][6].piece.color = :white
        end
        let(:source) { [7, 6] }
        let(:target) { [0, 6] }

        subject { inspector.right_white_rook_moved?(source, target) }

        it { is_expected.not_to be true }
      end
    end

    context 'When "Rook" movement is detected' do
      context 'with the source == [7, 7] && the piece == "Rook"' do
        before do
          board[0][7].piece.type = :Rook
          board[0][7].piece.color = :white
        end
        let(:source) { [7, 7] }
        let(:target) { [0, 7] }

        subject { inspector.right_white_rook_moved?(source, target) }

        it { is_expected.to be true }
      end
    end
  end
end
