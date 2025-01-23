# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/defend_king/defend_king'

describe DefendKing do
  let(:board) { Board.create }
  let(:movement_state) do
    double('MoveState', active_color: :black,
                        white_king_side_castle?: false, white_queen_side_castle?: false,
                        black_king_side_castle?: false, black_queen_side_castle?: false,
                        en_passant_target: '', half_move_clock: 0, full_move_number: 0)
  end

  describe '#trace_path' do
    let(:source) { [5, 4] }
    before do
      board[5][4].piece.type = :King
      board[5][4].piece.color = :black
    end

    context 'When the enemy is in a horizontal path' do
      let(:destination) { [[5, 0]] }
      let(:horizontal_enemy) { described_class.new(board, source, destination, movement_state) }
      before do
        board[5][0].piece.type = :Rook
        board[5][0].piece.color = :white
      end
      let(:result) { { [5, 0] => [[5, 3], [5, 2], [5, 1], [5, 0]] } }
      subject { horizontal_enemy.trace_path }

      it { is_expected.to include(result) }
    end

    context 'When the enemy is in a vertical path' do
      let(:destination) { [[7, 4]] }
      let(:vertical_enemy) { described_class.new(board, source, destination, movement_state) }
      before do
        board[7][4].piece.type = :Queen
        board[7][4].piece.color = :white
      end
      let(:result) { { [7, 4] => [[6, 4], [7, 4]] } }
      subject { vertical_enemy.trace_path }

      it { is_expected.to include(result) }
    end

    context 'When the enemy is in a diagonal path' do
      let(:destination) { [[2, 7], [7, 2]] }
      let(:diagonal_enemy) { described_class.new(board, source, destination, movement_state) }
      before do
        board[2][7].piece.type = :Bishop
        board[2][7].piece.color = :white
        board[7][2].piece.type = :Queen
        board[7][2].piece.color = :white
      end
      let(:result) { { [2, 7] => [[4, 5], [3, 6], [2, 7]], [7, 2] => [[6, 3], [7, 2]] } }
      subject { diagonal_enemy.trace_path }

      it { is_expected.to include(result) }
    end

    context "When the enemy is in a knight's path" do
      let(:destination) { [[3, 5], [6, 2]] }
      let(:knight_path_enemy) { described_class.new(board, source, destination, movement_state) }
      before do
        board[3][5].piece.type = :Knight
        board[3][5].piece.color = :white
        board[6][2].piece.type = :Knight
        board[6][2].piece.color = :white
      end
      let(:result) { { [3, 5] => [[3, 5]], [6, 2] => [[6, 2]] } }
      subject { knight_path_enemy.trace_path }

      it { is_expected.to include(result) }
    end

    context 'When the enemies are from all paths' do
      let(:destination) { [[5, 7], [4, 2], [0, 4], [1, 0], [7, 6]] }
      let(:multiple_path_enemy) { described_class.new(board, source, destination, movement_state) }
      before do
        board[5][7].piece.type = :Rook
        board[5][7].piece.color = :white
        board[4][2].piece.type = :Knight
        board[4][2].piece.color = :white
        board[0][4].piece.type = :Rook
        board[0][4].piece.color = :white
        board[1][0].piece.type = :Bishop
        board[1][0].piece.color = :white
        board[7][6].piece.type = :Queen
        board[7][6].piece.color = :white
      end
      let(:result) do
        { [5, 7] => [[5, 5], [5, 6], [5, 7]], [4, 2] => [[4, 2]],
          [0, 4] => [[4, 4], [3, 4], [2, 4], [1, 4], [0, 4]], [1, 0] => [[4, 3], [3, 2], [2, 1], [1, 0]],
          [7, 6] => [[6, 5], [7, 6]] }
      end
      subject { multiple_path_enemy.trace_path }

      it { is_expected.to include(result) }
    end
  end

  describe '#defenders' do
    context 'When interposing gets out of the "Check"' do
      let(:source) { [7, 3] }
      let(:destination) { [[5, 3]] }
      before do
        board[7][3].piece.type = :King
        board[7][3].piece.color = :white
        board[7][2].piece.type = :Rook
        board[7][2].piece.color = :white
        board[7][4].piece.type = :Rook
        board[7][4].piece.color = :white
        board[2][7].piece.type = :Bishop
        board[2][7].piece.color = :white
        board[5][3].piece.type = :Queen
        board[5][3].piece.color = :black
      end
      let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
      let(:result) { [[2, 7]] }
      subject { defender_pieces.defenders }

      it { is_expected.to match_array(result) }
    end

    context 'When capturing the piece gets out of the "Check"' do
      let(:source) { [7, 7] }
      let(:destination) { [[5, 7]] }
      before do
        board[7][7].piece.type = :King
        board[7][7].piece.color = :black
        board[5][7].piece.type = :Queen
        board[5][7].piece.color = :white
        board[5][2].piece.type = :Rook
        board[5][2].piece.color = :black
        board[6][1].piece.type = :Pawn
        board[6][1].piece.color = :black
      end
      let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
      let(:result) { [[5, 2], [7, 7]] }
      subject { defender_pieces.defenders }

      it { is_expected.to match_array(result) }
    end

    context 'When moving the "King" gets out of the "Check"' do
      let(:source) { [7, 7] }
      let(:destination) { [[5, 7]] }
      before do
        board[7][7].piece.type = :King
        board[7][7].piece.color = :white
        board[5][7].piece.type = :Queen
        board[5][7].piece.color = :black
        board[7][5].piece.type = :Rook
        board[7][5].piece.color = :white
      end
      let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
      let(:result) { [[7, 7]] }
      subject { defender_pieces.defenders }

      it { is_expected.to match_array(result) }
    end

    context 'When all of the options gets out of the "Check"' do
      let(:source) { [7, 3] }
      let(:destination) { [[5, 3]] }
      before do
        board[7][3].piece.type = :King
        board[7][3].piece.color = :white
        board[5][0].piece.type = :Rook
        board[5][0].piece.color = :white
        board[7][4].piece.type = :Rook
        board[7][4].piece.color = :white
        board[2][7].piece.type = :Bishop
        board[2][7].piece.color = :white
        board[5][3].piece.type = :Queen
        board[5][3].piece.color = :black
      end
      let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
      let(:result) { [[2, 7], [5, 0], [7, 3]] }
      subject { defender_pieces.defenders }

      it { is_expected.to match_array(result) }
    end

    context 'When there are more than one enemies' do
      let(:source) { [0, 7] }
      let(:destination) { [[2, 6], [5, 7]] }

      context 'with only moving the "King" gets out of the "Check"' do
        before do
          board[0][7].piece.type = :King
          board[0][7].piece.color = :black
          board[2][6].piece.type = :Knight
          board[2][6].piece.color = :white
          board[5][7].piece.type = :Rook
          board[5][7].piece.color = :white
          board[1][6].piece.type = :Pawn
          board[1][6].piece.color = :black
        end
        let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
        let(:result) { [[0, 7]] }
        subject { defender_pieces.defenders }

        it { is_expected.to match_array(result) }
      end

      context 'with interposing / capturing blocks only one "Check", moving "King" gets out of the "Check"' do
        before do
          board[0][7].piece.type = :King
          board[0][7].piece.color = :black
          board[2][6].piece.type = :Knight
          board[2][6].piece.color = :white
          board[5][7].piece.type = :Rook
          board[5][7].piece.color = :white
          board[1][6].piece.type = :Pawn
          board[1][6].piece.color = :black
          board[5][2].piece.type = :Queen
          board[5][2].piece.color = :black
          board[3][4].piece.type = :Rook
          board[3][4].piece.color = :black
        end
        let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
        let(:result) { [[0, 7]] }
        subject { defender_pieces.defenders }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When none of the options gets out of the "Check"' do
      let(:source) { [7, 3] }
      let(:destination) { [[5, 3]] }
      before do
        board[7][3].piece.type = :King
        board[7][3].piece.color = :black
        board[7][2].piece.type = :Rook
        board[7][2].piece.color = :black
        board[7][4].piece.type = :Rook
        board[7][4].piece.color = :black
        board[5][3].piece.type = :Queen
        board[5][3].piece.color = :white
      end
      let(:defender_pieces) { described_class.new(board, source, destination, movement_state) }
      let(:result) { [] }
      subject { defender_pieces.defenders }

      it { is_expected.to eq(result) }
    end
  end
end
