# frozen_string_literal: true

require_relative '../lib/conditions_to_win/conditions_to_win'

# rubocop:disable Metrics/BlockLength
describe ConditionsToWin do
  subject(:winning_conditions) { described_class.new }
  let(:not_connected_board) do
    [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0],
      [0, 0, 2, 2, 2, 1, 0],
      [0, 0, 1, 2, 1, 2, 0],
      [0, 0, 1, 2, 1, 2, 0]
    ]
  end

  describe '#horizontal_connection?' do
    let(:horizontal_win) do
      [
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0],
        [0, 0, 2, 2, 2, 2, 0],
        [0, 0, 1, 2, 1, 2, 0],
        [0, 0, 1, 2, 1, 2, 0]
      ]
    end
    before { winning_conditions.instance_variable_set(:@matrix_array, horizontal_win) }

    context 'When the discs are connected' do
      context 'With the connection is from left -> right' do
        subject { winning_conditions.horizontal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [3, 2])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end

      context 'With the connection is from right -> left' do
        subject { winning_conditions.horizontal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [3, 5])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end

      context 'With the connection can be left <==> right' do
        subject { winning_conditions.horizontal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [3, 3])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end
    end

    context 'When the discs are not connected' do
      subject { winning_conditions.horizontal_connection? }

      before do
        winning_conditions.instance_variable_set(:@matrix_array, not_connected_board)
        winning_conditions.instance_variable_set(:@indices, [3, 3])
        winning_conditions.instance_variable_set(:@player_id, 2)
      end

      it { is_expected.not_to be true }
    end
  end

  describe '#vertical_connection?' do
    let(:vertical_win) do
      [
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0],
        [0, 0, 1, 1, 0, 0, 0],
        [0, 0, 1, 2, 2, 1, 0],
        [0, 0, 1, 2, 1, 2, 0],
        [0, 0, 0, 2, 1, 2, 0]
      ]
    end
    before { winning_conditions.instance_variable_set(:@matrix_array, vertical_win) }

    context 'When the discs are connected' do
      context 'With the connection is from top -> bottom' do
        subject { winning_conditions.vertical_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [1, 2])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end

      context 'With the connection is from bottom -> top' do
        subject { winning_conditions.vertical_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [4, 2])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end

      context 'With the connection can be top <==> bottom' do
        subject { winning_conditions.vertical_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [3, 2])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end
    end

    context 'When the discs are not connected' do
      subject { winning_conditions.vertical_connection? }

      before do
        winning_conditions.instance_variable_set(:@matrix_array, not_connected_board)
        winning_conditions.instance_variable_set(:@indices, [3, 3])
        winning_conditions.instance_variable_set(:@player_id, 2)
      end

      it { is_expected.not_to be true }
    end
  end

  describe '#leading_diagonal_connection?' do
    let(:leading_diagonal_win) do
      [
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 1, 1, 0, 0],
        [0, 0, 1, 1, 2, 1, 0],
        [0, 0, 1, 2, 1, 2, 0],
        [0, 0, 0, 2, 1, 1, 0]
      ]
    end
    before { winning_conditions.instance_variable_set(:@matrix_array, leading_diagonal_win) }

    context 'When the discs are connected' do
      context 'With the connection is from upward -> downward' do
        subject { winning_conditions.leading_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [2, 2])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end

      context 'With the connection is from downward -> upward' do
        subject { winning_conditions.leading_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [5, 5])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end

      context 'With the connection can be upward <==> downward' do
        subject { winning_conditions.leading_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [4, 4])
          winning_conditions.instance_variable_set(:@player_id, 1)
        end

        it { is_expected.to be true }
      end
    end

    context 'When the discs are not connected' do
      subject { winning_conditions.leading_diagonal_connection? }

      before do
        winning_conditions.instance_variable_set(:@matrix_array, not_connected_board)
        winning_conditions.instance_variable_set(:@indices, [3, 3])
        winning_conditions.instance_variable_set(:@player_id, 2)
      end

      it { is_expected.not_to be true }
    end
  end

  describe '#trailing_diagonal_connection?' do
    let(:trailing_diagonal_win) do
      [
        [0, 0, 0, 2, 0, 0, 0],
        [0, 0, 2, 1, 2, 0, 0],
        [0, 2, 1, 1, 1, 0, 0],
        [2, 1, 2, 1, 2, 1, 0],
        [2, 1, 1, 2, 1, 2, 0],
        [1, 0, 0, 2, 1, 2, 0]
      ]
    end
    before { winning_conditions.instance_variable_set(:@matrix_array, trailing_diagonal_win) }

    context 'When the discs are connected' do
      context 'With the connection is from upward -> downward' do
        subject { winning_conditions.trailing_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [0, 3])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end

      context 'With the connection is from downward -> upward' do
        subject { winning_conditions.trailing_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [3, 0])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end

      context 'With the connection can be upward <==> downward' do
        subject { winning_conditions.trailing_diagonal_connection? }

        before do
          winning_conditions.instance_variable_set(:@indices, [2, 1])
          winning_conditions.instance_variable_set(:@player_id, 2)
        end

        it { is_expected.to be true }
      end
    end

    context 'When the discs are not connected' do
      subject { winning_conditions.leading_diagonal_connection? }

      before do
        winning_conditions.instance_variable_set(:@matrix_array, not_connected_board)
        winning_conditions.instance_variable_set(:@indices, [2, 3])
        winning_conditions.instance_variable_set(:@player_id, 1)
      end

      it { is_expected.not_to be true }
    end
  end

  describe '#count_next_discs' do
    let(:fully_connected_board) do
      [
        [0, 0, 0, 2, 0, 0, 0],
        [0, 0, 2, 1, 2, 0, 0],
        [0, 2, 1, 1, 1, 0, 0],
        [2, 1, 2, 1, 2, 1, 0],
        [2, 1, 1, 2, 1, 2, 0],
        [1, 0, 0, 2, 1, 2, 0]
      ]
    end
    let(:partially_connected_board) do
      [
        [0, 0, 0, 2, 0, 0, 0],
        [0, 0, 0, 1, 2, 0, 0],
        [0, 2, 1, 1, 1, 0, 0],
        [2, 1, 2, 1, 2, 1, 0],
        [2, 1, 1, 2, 1, 2, 0],
        [1, 0, 0, 2, 1, 2, 0]
      ]
    end

    context 'When given a fully connected board' do
      subject { winning_conditions.count_next_discs(row, column) }
      let(:row) { 3 }
      let(:column) { 0 }
      before do
        winning_conditions.instance_variable_set(:@player_id, 2)
        winning_conditions.instance_variable_set(:@matrix_array, fully_connected_board)
        winning_conditions.instance_variable_set(:@has_to_decrement_row, true)
        winning_conditions.instance_variable_set(:@has_to_increment_column, true)
      end

      it { is_expected.to eq(3) }
    end

    context 'When given a partially connected board' do
      subject { winning_conditions.count_next_discs(row, column) }
      let(:row) { 2 }
      let(:column) { 2 }
      before do
        winning_conditions.instance_variable_set(:@player_id, 1)
        winning_conditions.instance_variable_set(:@matrix_array, partially_connected_board)
        winning_conditions.instance_variable_set(:@has_to_increment_row, true)
        winning_conditions.instance_variable_set(:@has_to_increment_column, true)
      end

      it { is_expected.to eq(2) }
    end

    context 'When given a not connected board' do
      subject { winning_conditions.count_next_discs(row, column) }
      let(:row) { 2 }
      let(:column) { 3 }
      before do
        winning_conditions.instance_variable_set(:@player_id, 1)
        winning_conditions.instance_variable_set(:@matrix_array, not_connected_board)
        winning_conditions.instance_variable_set(:@has_to_increment_column, true)
      end

      it { is_expected.to be_zero }
    end
  end

  describe '#conditions_satisfied?' do
    context 'When the discs are connected inside the board' do
      let(:winning_board) do
        [
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0],
          [0, 0, 1, 1, 1, 0, 0],
          [0, 0, 1, 1, 2, 1, 0],
          [0, 0, 1, 2, 1, 2, 0],
          [0, 0, 0, 2, 1, 1, 0]
        ]
      end
      let(:indices) { [3, 3] }
      let(:player_id) { 1 }

      subject { winning_conditions.conditions_satisfied?(winning_board, indices, player_id) }

      it { is_expected.to be true }
    end

    context 'When the discs are not connected inside the board' do
      let(:indices) { [3, 3] }
      let(:player_id) { 2 }

      subject { winning_conditions.conditions_satisfied?(not_connected_board, indices, player_id) }

      it { is_expected.not_to be true }
    end
  end
end
# rubocop:enable Metrics/BlockLength
