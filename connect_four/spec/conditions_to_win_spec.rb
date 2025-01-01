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
end
# rubocop:enable Metrics/BlockLength
