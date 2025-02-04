# frozen_string_literal: true

require_relative '../lib/game_board//game_board'
require_relative '../lib/conditions_to_win/conditions_to_win'

# rubocop:disable Metrics/BlockLength
describe GameBoard do
  subject(:game_board) { described_class.new(winning_conditions) }
  let(:board) { game_board.instance_variable_get(:@board) }
  let(:winning_conditions) { double('winning_conditions') }

  describe '#initialize' do
    context "When it's instantiated" do
      let(:model_board) do
        [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0]
        ]
      end

      it 'should assign a matrix-array for an instance variable' do
        expect(board).to eq(model_board)
      end
    end
  end

  describe '#update_board' do
    context 'When the column is empty' do
      let(:model_board) do
        [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 1, 0]
        ]
      end

      before do
        game_board.update_board(position, player_id)
      end

      let(:position)  { 6 }
      let(:player_id) { 1 }

      it 'should update from bottom-up row' do
        expect(board).to eq(model_board)
      end
      context 'When the index is determined' do
        let(:previous_move) { game_board.instance_variable_get(:@last_move) }

        it 'should assign the current move to the last_move variable' do
          current_move = [5, 5]
          expect(previous_move).to eq(current_move)
        end
      end
    end

    context 'When the column is not empty' do
      let(:model_board) do
        [
          [0, 0, 2, 0, 0, 0, 0],
          [0, 0, 2, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0],
          [2, 0, 2, 0, 0, 0, 0],
          [1, 0, 1, 0, 0, 1, 0],
          [2, 0, 2, 1, 2, 1, 0]
        ]
      end

      before do
        set_board = [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 2, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0],
          [2, 0, 2, 0, 0, 0, 0],
          [1, 0, 1, 0, 0, 1, 0],
          [2, 0, 2, 1, 2, 1, 0]
        ]
        game_board.instance_variable_set(:@board, set_board)
        game_board.update_board(position, player_id)
      end
      let(:position) { 3 }
      let(:player_id) { 2 }

      it 'should skip the already marked row & moves upward (row - 1)' do
        expect(board).to eq(model_board)
      end

      context 'When the index is determined' do
        let(:previous_move) { game_board.instance_variable_get(:@last_move) }

        it 'should assign the current move to the last_move variable' do
          current_move = [0, 2]
          expect(previous_move).to eq(current_move)
        end
      end
    end
  end

  describe '#valid_position?' do
    context 'When position is valid in an empty column' do
      let(:position) { 3 }
      subject { game_board.valid_position?(position) }

      it { is_expected.to be true }
    end

    context 'When position is valid in a non-empty column' do
      let(:position) { 5 }
      before do
        set_board = [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 2, 0, 1, 0, 0],
          [0, 0, 1, 0, 1, 0, 0],
          [2, 0, 2, 0, 2, 0, 0],
          [1, 0, 1, 0, 1, 1, 0],
          [2, 0, 2, 1, 2, 1, 0]
        ]
        game_board.instance_variable_set(:@board, set_board)
      end

      subject { game_board.valid_position?(position) }

      it { is_expected.to be true }
    end

    context 'When position is invalid(out of bound)' do
      let(:position) { 8 }
      subject { game_board.valid_position?(position) }

      it { is_expected.to be false }
    end

    context 'When position is valid, however the column is full' do
      let(:position) { 3 }
      before do
        set_board = [
          [0, 0, 1, 0, 0, 0, 0],
          [0, 0, 2, 0, 1, 0, 0],
          [0, 0, 1, 0, 1, 0, 0],
          [2, 0, 2, 0, 2, 0, 0],
          [1, 0, 1, 0, 1, 1, 0],
          [2, 0, 2, 1, 2, 1, 0]
        ]
        game_board.instance_variable_set(:@board, set_board)
      end

      subject { game_board.valid_position?(position) }

      it { is_expected.to be false }
    end
  end

  describe '#tie?' do
    context 'When the board is not full' do
      it 'should return false' do
        expect(game_board).not_to be_tie
      end
    end

    context 'When the board is full' do
      before do
        set_board = [
          [1, 2, 1, 1, 2, 1, 2],
          [1, 1, 2, 1, 1, 2, 1],
          [2, 1, 1, 2, 2, 2, 1],
          [2, 2, 2, 1, 2, 1, 2],
          [1, 1, 1, 2, 1, 1, 1],
          [2, 2, 2, 1, 2, 1, 2]
        ]
        game_board.instance_variable_set(:@board, set_board)
      end

      it 'should return true' do
        expect(game_board).to be_tie
      end
    end
  end

  describe '#won?' do
    let(:board_with_wins) { described_class.new(win_conditions) }
    let(:win_conditions) { instance_double(ConditionsToWin) }

    context 'When player_id is given' do
      it 'should send messages to the "ConditionsToWin#conditions_satisfied?"' do
        expect(win_conditions).to receive(:conditions_satisfied?)
        player_id = 2
        board_with_wins.won?(player_id)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
