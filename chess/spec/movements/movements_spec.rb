# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/movements/movements'
require_relative '../../lib/fen/fen'

describe Movements do
  describe '#legal_moves' do
    let(:board) { Board.create }
    let(:resolved_fen_string) do
      FEN::FENResolver.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1').resolve
    end
    let(:moves) { resolved_fen_string.last }
    let(:movement_state) do
      double('MoveState', active_color: moves[0],
                          white_king_side_castle?: moves[1], white_queen_side_castle?: moves[2],
                          black_king_side_castle?: moves[3], black_queen_side_castle?: moves[4],
                          en_passant_target: moves[5], half_move_clock: moves[6], full_move_number: moves[7])
    end

    context 'When the pieces are all in a starting position' do
      let(:updated_board) { Board.place_pieces(resolved_fen_string.first, board) }
      let(:movements) { described_class.new(updated_board, movement_state) }

      context 'with the "White" piece being the active color' do
        subject { movements.legal_moves }
        let(:result) { [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7], [7, 1], [7, 6]] }

        it { is_expected.to match_array(result) }
      end

      context 'with the "Black" piece being the active color' do
        before { moves[0] = :black }

        subject { movements.legal_moves }
        let(:result) { [[0, 1], [0, 6], [1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]] }

        it { is_expected.to match_array(result) }
      end
    end

    context 'When the "King" is in "Check"' do
      let(:movements) { described_class.new(board, movement_state) }

      context 'with "Capturing" is the only option' do
        before do
          moves[0] = :black
          board[4][7].piece.type = :Queen
          board[4][7].piece.color = :white

          board[7][7].piece.type = :King
          board[7][7].piece.color = :black
          board[7][6].piece.type = :Rook
          board[7][6].piece.color = :black
          board[6][6].piece.type = :Pawn
          board[6][6].piece.color = :black
          board[1][4].piece.type = :Queen
          board[1][4].piece.color = :black
        end

        subject { movements.legal_moves }
        let(:result) { [[1, 4]] }

        it { is_expected.to match_array(result) }
      end

      context 'with "Interposing" is the only option' do
        before do
          board[5][3].piece.type = :Queen
          board[5][3].piece.color = :black

          board[7][3].piece.type = :King
          board[7][3].piece.color = :white
          board[7][2].piece.type = :Rook
          board[7][2].piece.color = :white
          board[7][4].piece.type = :Rook
          board[7][4].piece.color = :white
          board[2][7].piece.type = :Bishop
          board[2][7].piece.color = :white
        end

        subject { movements.legal_moves }
        let(:result) { [[2, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with moving the "King" is the only option' do
        before do
          board[5][7].piece.type = :Queen
          board[5][7].piece.color = :black

          board[7][7].piece.type = :King
          board[7][7].piece.color = :white
          board[7][5].piece.type = :Rook
          board[7][5].piece.color = :white
          board[6][5].piece.type = :Pawn
          board[6][5].piece.color = :white
        end

        subject { movements.legal_moves }
        let(:result) { [[7, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with "Capture", "Protect", "Run away" all options are available' do
        before do
          moves[0] = :black
          board[5][3].piece.type = :Queen
          board[5][3].piece.color = :white

          board[7][3].piece.type = :King
          board[7][3].piece.color = :black
          board[7][2].piece.type = :Rook
          board[7][2].piece.color = :black
          board[5][7].piece.type = :Rook
          board[5][7].piece.color = :black
          board[2][7].piece.type = :Bishop
          board[2][7].piece.color = :black
        end

        subject { movements.legal_moves }
        let(:result) { [[7, 3], [5, 7], [2, 7]] }

        it { is_expected.to match_array(result) }
      end

      context 'with no escape & the "King" is in "Checkmate"' do
        before do
          moves[0] = :black
          board[2][4].piece.type = :Queen
          board[2][4].piece.color = :white

          board[0][4].piece.type = :King
          board[0][4].piece.color = :black
          board[0][3].piece.type = :Rook
          board[0][3].piece.color = :black
          board[0][5].piece.type = :Rook
          board[0][5].piece.color = :black
        end

        subject { movements.legal_moves }

        it { is_expected.to be_empty }
      end
    end

    context 'When there are only a few legal moves' do
      let(:movements) { described_class.new(board, movement_state) }

      before do
        board[0][1].piece.type = :Bishop
        board[0][1].piece.color = :black
        board[5][7].piece.type = :Pawn
        board[5][7].piece.color = :black

        board[1][0].piece.type = :Pawn
        board[1][0].piece.color = :white
        board[6][7].piece.type = :Pawn
        board[6][7].piece.color = :white
        board[7][7].piece.type = :King
        board[7][7].piece.color = :white
      end

      subject { movements.legal_moves }
      let(:result) { [[1, 0], [7, 7]] }

      it { is_expected.to match_array(result) }
    end

    context 'When there are no legal moves & the situation is a "Stalemate"' do
      let(:movements) { described_class.new(board, movement_state) }

      before do
        board[1][0].piece.type = :Bishop
        board[1][0].piece.color = :black
        board[5][7].piece.type = :Pawn
        board[5][7].piece.color = :black

        board[6][7].piece.type = :Pawn
        board[6][7].piece.color = :white
        board[7][7].piece.type = :King
        board[7][7].piece.color = :white
      end

      subject { movements.legal_moves }

      it { is_expected.to be_empty }
    end
  end
end
