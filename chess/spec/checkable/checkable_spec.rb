# frozen_string_literal: true

require_relative '../../lib/board/board'
require_relative '../../lib/checkable/checkable'

describe Checkable do
  let(:board) { Board.create }

  describe '.enemy_whereabouts' do
    context 'When given a position of the "King" & a "Board"' do
      let(:enemies_of_king) { described_class }
      let(:position) { [3, 5] }

      it 'should instantiate "HorizontalCheckable", "VerticalCheckable", "DiagonalCheckable", "KnightCheckable"' do
        expect_any_instance_of(Checkable::HorizontalCheckable).to receive(:enemy_whereabouts).and_call_original
        expect_any_instance_of(Checkable::VerticalCheckable).to receive(:enemy_whereabouts).and_call_original
        expect_any_instance_of(Checkable::DiagonalCheckable).to receive(:enemy_whereabouts).and_call_original
        expect_any_instance_of(Checkable::KnightCheckable).to receive(:enemy_whereabouts).and_call_original

        enemies_of_king.enemy_whereabouts(board, position)
      end
    end
  end
end
