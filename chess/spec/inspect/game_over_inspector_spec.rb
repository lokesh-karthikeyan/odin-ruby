# frozen_string_literal: true

require_relative '../../lib/inspect/game_over_inspector'
require_relative '../../lib/board/board'
require_relative '../../lib/state/state'

describe GameOverInspector do
  let(:movements) { [:white, true, true, true, true, '-', 0, 1] }
  let(:board) { Board.create }
  let(:move_state) { State.create_move_state(movements) }
  let(:inspector) { described_class.new(board, move_state) }

  describe '#check?' do
    context 'When the "King" is in check' do
      before do
        board[7][0].piece.type = :King
        board[7][0].piece.color = :white
        board[7][1].piece.type = :Bishop
        board[7][1].piece.color = :white

        board[0][0].piece.type = :Rook
        board[0][0].piece.color = :black
        board[6][7].piece.type = :Queen
        board[6][7].piece.color = :black
      end

      subject { inspector.check?([[7, 0], [7, 1]]) }

      it { is_expected.to be true }
    end

    context 'When the "King" is NOT in check' do
      before do
        board[7][0].piece.type = :King
        board[7][0].piece.color = :white
        board[7][1].piece.type = :Bishop
        board[7][1].piece.color = :white

        board[6][2].piece.type = :Rook
        board[6][2].piece.color = :black
      end

      subject { inspector.check?([[7, 0], [7, 1]]) }

      it { is_expected.not_to be true }
    end
  end

  describe '#three_fold_repetition?' do
    context 'When the identical board & movements occured for more than 3 times' do
      let(:game_logs) do
        {
          "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -": 1, "4k2r/6r1/8/8/8/8/3R4/R3K3 w Qk -": 2,
          "8/5k2/3p4/1p1Pp2p/pP2Pp1P/P4P1K/8/8 b - -": 3
        }
      end
      subject { inspector.three_fold_repetition?(game_logs) }

      it { is_expected.to be true }
    end

    context 'When the identical board & movements occured for less than 3 times' do
      let(:game_logs) do
        {
          "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -": 1, "4k2r/6r1/8/8/8/8/3R4/R3K3 w Qk -": 2,
          "8/5k2/3p4/1p1Pp2p/pP2Pp1P/P4P1K/8/8 b - -": 2
        }
      end
      subject { inspector.three_fold_repetition?(game_logs) }

      it { is_expected.not_to be true }
    end
  end

  describe '#fifty_move_rule?' do
    context 'When the "Half-move" clock turns greater than 100' do
      before { movements[6] = 100 }
      subject { inspector.fifty_move_rule? }

      it { is_expected.to be true }
    end

    context 'When the "Half-move" clock is less than 100' do
      before { movements[6] = 99 }
      subject { inspector.fifty_move_rule? }

      it { is_expected.not_to be true }
    end
  end
end
