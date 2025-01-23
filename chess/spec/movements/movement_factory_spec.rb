# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/movements/movement_factory'

describe MovementFactory do
  let(:board) { Board.create }
  let(:movement_factory) { described_class }
  let(:movement_state) do
    double('MoveState', active_color: :black,
                        white_king_side_castle?: false, white_queen_side_castle?: false,
                        black_king_side_castle?: false, black_queen_side_castle?: false,
                        en_passant_target: '', half_move_clock: 0, full_move_number: 0)
  end

  describe '.moves' do
    context 'When the spot has a "Pawn" piece' do
      let(:position) { [3, 5] }

      context 'with the piece color == :white' do
        before do
          board[3][5].piece.type = :Pawn
          board[3][5].piece.color = :white
        end

        it 'should instantiate "WhitePawnMoves" class' do
          expect_any_instance_of(WhitePawnMoves).to receive(:legal_moves).and_call_original

          movement_factory.moves(board, position, movement_state)
        end
      end

      context 'with the piece color == :black' do
        before do
          board[3][5].piece.type = :Pawn
          board[3][5].piece.color = :black
        end

        it 'should instantiate "BlackPawnMoves" class' do
          expect_any_instance_of(BlackPawnMoves).to receive(:legal_moves).and_call_original

          movement_factory.moves(board, position, movement_state)
        end
      end
    end

    context 'When the spot has a "Rook" piece' do
      let(:position) { [0, 7] }
      before do
        board[0][7].piece.type = :Rook
        board[0][7].piece.color = :white
      end

      it 'should instantiate "RookMoves" class' do
        expect_any_instance_of(RookMoves).to receive(:legal_moves).and_call_original

        movement_factory.moves(board, position, movement_state)
      end
    end

    context 'When the spot has a "Knight" piece' do
      let(:position) { [7, 1] }
      before do
        board[7][1].piece.type = :Knight
        board[7][1].piece.color = :black
      end

      it 'should instantiate "KnightMoves" class' do
        expect_any_instance_of(KnightMoves).to receive(:legal_moves).and_call_original

        movement_factory.moves(board, position, movement_state)
      end
    end

    context 'When the spot has a "Bishop" piece' do
      let(:position) { [0, 5] }
      before do
        board[0][5].piece.type = :Bishop
        board[0][5].piece.color = :white
      end

      it 'should instantiate "BishopMoves" class' do
        expect_any_instance_of(BishopMoves).to receive(:legal_moves).and_call_original

        movement_factory.moves(board, position, movement_state)
      end
    end

    context 'When the spot has a "Queen" piece' do
      let(:position) { [7, 3] }
      before do
        board[7][3].piece.type = :Queen
        board[7][3].piece.color = :black
      end

      it 'should instantiate "QueenMoves" class' do
        expect_any_instance_of(QueenMoves).to receive(:legal_moves).and_call_original

        movement_factory.moves(board, position, movement_state)
      end
    end

    context 'When the spot has a "King" piece' do
      let(:position) { [0, 4] }
      before do
        board[0][4].piece.type = :King
        board[0][4].piece.color = :white
      end

      it 'should instantiate "KingMoves" class' do
        expect_any_instance_of(KingMoves).to receive(:legal_moves).and_call_original

        movement_factory.moves(board, position, movement_state)
      end
    end
  end
end
