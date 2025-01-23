# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/movements/king_moves/king_moves'

describe KingMoves do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:movement_state) do
      double('MoveState', active_color: :black,
                          white_king_side_castle?: false, white_queen_side_castle?: false,
                          black_king_side_castle?: false, black_queen_side_castle?: false,
                          en_passant_target: '', half_move_clock: 0, full_move_number: 0)
    end

    context 'When the King was not blocked by any pieces & position -> [5, 2]' do
      let(:position) { [5, 2] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[5][2].piece.type = :King
        board[5][2].piece.color = :black
      end

      subject { king_moves.legal_moves }
      let(:result) { [[5, 1], [4, 1], [4, 2], [4, 3], [5, 3], [6, 3], [6, 2], [6, 1]] }

      it { is_expected.to match_array(result) }
    end

    context 'When the King was blocked & position -> [3, 5]' do
      let(:position) { [3, 5] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[3][5].piece.type = :King
        board[3][5].piece.color = :black
      end

      context 'with an ally piece at [3, 6]' do
        before do
          board[3][6].piece.type = :Pawn
          board[3][6].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[3, 4], [2, 4], [2, 5], [2, 6], [4, 6], [4, 5], [4, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with an enemy piece at [4, 4]' do
        before do
          board[4][4].piece.type = :Pawn
          board[4][4].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [[3, 4], [2, 4], [2, 5], [2, 6], [3, 6], [4, 6], [4, 5], [4, 4]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the King was at corner spot -> [7, 7]' do
      let(:position) { [7, 7] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[7][7].piece.type = :King
        board[7][7].piece.color = :white
      end

      context 'with being blocked by an enemy piece' do
        before do
          board[7][6].piece.type = :Rook
          board[7][6].piece.color = :black
          board[6][6].piece.type = :Bishop
          board[6][6].piece.color = :black
          board[6][7].piece.type = :Pawn
          board[6][7].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[6, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with being blocked by an ally piece' do
        before do
          board[7][6].piece.type = :Rook
          board[7][6].piece.color = :white
          board[6][6].piece.type = :Bishop
          board[6][6].piece.color = :white
          board[6][7].piece.type = :Pawn
          board[6][7].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When one of the "Moves" is in a check' do
      let(:position) { [2, 2] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[2][2].piece.type = :King
        board[2][2].piece.color = :white
      end

      context 'with the check was made in a horizontal & vertical path' do
        before do
          board[1][7].piece.type = :Rook
          board[1][7].piece.color = :black
          board[7][3].piece.type = :Queen
          board[7][3].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[2, 1], [3, 2], [3, 1]] }

        it { is_expected.to match_array(result) }
      end

      context "with the check was made in a diagonal & knight's path" do
        before do
          board[7][7].piece.type = :Queen
          board[7][7].piece.color = :black
          board[1][4].piece.type = :Pawn
          board[1][4].piece.color = :black
          board[2][4].piece.type = :Knight
          board[2][4].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[2, 1], [1, 3], [3, 1]] }

        it { is_expected.to match_array(result) }
      end

      context 'with the check was made in all paths' do
        before do
          board[7][1].piece.type = :Rook
          board[7][1].piece.color = :black
          board[1][5].piece.type = :Rook
          board[1][5].piece.color = :black
          board[0][5].piece.type = :Bishop
          board[0][5].piece.color = :black
          board[3][6].piece.type = :Queen
          board[3][6].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [] }

        it { is_expected.to eq(result) }
      end
    end

    context 'When "Castling" is allowed, but circumstances prevented castling' do
      let(:movement_state) do
        double('MoveState', active_color: :black,
                            white_king_side_castle?: true, white_queen_side_castle?: true,
                            black_king_side_castle?: true, black_queen_side_castle?: true,
                            en_passant_target: '', half_move_clock: 0, full_move_number: 0)
      end
      let(:position) { [0, 4] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[0][4].piece.type = :King
        board[0][4].piece.color = :black
        board[0][0].piece.type = :Rook
        board[0][0].piece.color = :black
        board[0][7].piece.type = :Rook
        board[0][7].piece.color = :black
      end

      context 'with "King" is in "Check"' do
        before do
          board[4][0].piece.type = :Bishop
          board[4][0].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [[0, 3], [0, 5], [1, 4], [1, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with the path that "King" travels is in "Check"' do
        before do
          board[7][5].piece.type = :Rook
          board[7][5].piece.color = :white
          board[3][0].piece.type = :Bishop
          board[3][0].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [[1, 3], [1, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with the destination is at "Check"' do
        before do
          board[7][6].piece.type = :Rook
          board[7][6].piece.color = :white
          board[1][1].piece.type = :Pawn
          board[1][1].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [[0, 3], [1, 3], [1, 4], [1, 5], [0, 5]] }

        it { is_expected.to match_array(result) }
      end

      context 'with the paths between "Rook" and "King" is not empty' do
        before do
          board[0][1].piece.type = :Knight
          board[0][1].piece.color = :black
          board[0][5].piece.type = :Bishop
          board[0][5].piece.color = :white
        end

        subject { king_moves.legal_moves }
        let(:result) { [[0, 3], [1, 3], [1, 5], [0, 5]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When "Castling" is allowed' do
      let(:movement_state) do
        double('MoveState', active_color: :black,
                            white_king_side_castle?: true, white_queen_side_castle?: true,
                            black_king_side_castle?: true, black_queen_side_castle?: true,
                            en_passant_target: '', half_move_clock: 0, full_move_number: 0)
      end
      let(:position) { [7, 4] }
      let(:king_moves) { described_class.new(board, position, movement_state) }
      before do
        board[7][4].piece.type = :King
        board[7][4].piece.color = :white
        board[7][0].piece.type = :Rook
        board[7][0].piece.color = :white
        board[7][7].piece.type = :Rook
        board[7][7].piece.color = :white
      end
      context 'with both "King side" and "Queen side"' do
        subject { king_moves.legal_moves }
        let(:result) { [[7, 3], [6, 3], [6, 4], [6, 5], [7, 5], [7, 2], [7, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with "King side" alone' do
        before do
          board[3][2].piece.type = :Rook
          board[3][2].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[7, 3], [6, 3], [6, 4], [6, 5], [7, 5], [7, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with "Queen side" alone' do
        before do
          board[6][6].piece.type = :Pawn
          board[6][6].piece.color = :black
        end

        subject { king_moves.legal_moves }
        let(:result) { [[7, 3], [6, 3], [6, 4], [6, 5], [7, 2]] }

        it { is_expected.to match_array(result) }
      end
    end
  end
end
