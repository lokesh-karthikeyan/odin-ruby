# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/movements/pawn_moves'

describe PawnMoves do
  let(:board) { Board.create }

  describe '#legal_moves' do
    context 'When the Pawn is a "Black" piece' do
      let(:position) { [1, 3] }
      let(:movement_state) do
        double('MoveState', active_color: :black,
                            white_king_side_castle?: false, white_queen_side_castle?: false,
                            black_king_side_castle?: false, black_queen_side_castle?: false,
                            en_passant_target: '', half_move_clock: 0, full_move_number: 0)
      end
      before do
        board[1][3].piece.type = :Pawn
        board[1][3].piece.color = :black
      end
      subject(:pawn_moves) { described_class.new(board, position, movement_state) }

      it 'should instantiate "BlackPawnMoves" class & send messages to "#legal_moves" method' do
        expect_any_instance_of(BlackPawnMoves).to receive(:legal_moves)
        pawn_moves.legal_moves
      end
    end

    context 'When the Pawn is a "White" piece' do
      let(:position) { [6, 6] }
      let(:movement_state) do
        double('MoveState', active_color: :white,
                            white_king_side_castle?: false, white_queen_side_castle?: false,
                            black_king_side_castle?: false, black_queen_side_castle?: false,
                            en_passant_target: '', half_move_clock: 0, full_move_number: 0)
      end
      before do
        board[6][6].piece.type = :Pawn
        board[6][6].piece.color = :white
      end
      subject(:pawn_moves) { described_class.new(board, position, movement_state) }

      it 'should instantiate "WhitePawnMoves" class & send messages to "#legal_moves" method' do
        expect_any_instance_of(WhitePawnMoves).to receive(:legal_moves)
        pawn_moves.legal_moves
      end
    end
  end
end
