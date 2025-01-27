# frozen_string_literal: true

require_relative '../../lib/inspect/half_move_clock_inspector'

describe HalfMoveClockInspector do
  let(:inspector) { described_class.new }

  describe '#increment_count?' do
    context 'When the count is not incrementable' do
      context 'When the source is a "Black Pawn" && the target is a "Null piece"' do
        let(:source_piece_attributes) { %i[Pawn black] }
        let(:target_piece_attributes) { ['', ''] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.not_to be true }
      end

      context 'When the source is a "White Pawn && the target is a "Null piece"' do
        let(:source_piece_attributes) { %i[Pawn white] }
        let(:target_piece_attributes) { ['', ''] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.not_to be true }
      end

      context 'When the target contains a piece && the source is not a "Pawn"' do
        let(:source_piece_attributes) { %i[Queen white] }
        let(:target_piece_attributes) { %i[Rook black] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.not_to be true }
      end

      context 'When the source contains "Pawn" && the target contains a piece' do
        let(:source_piece_attributes) { %i[Pawn black] }
        let(:target_piece_attributes) { %i[Bishop white] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.not_to be true }
      end
    end

    context 'When the count is incrementable' do
      context 'When the source is not a "Pawn" && the target is a "Null piece"' do
        let(:source_piece_attributes) { %i[Queen black] }
        let(:target_piece_attributes) { ['', ''] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.to be true }
      end

      context 'When during the castling move' do
        let(:source_piece_attributes) { %i[King white] }
        let(:target_piece_attributes) { ['', ''] }

        subject { inspector.increment_count?(source_piece_attributes, target_piece_attributes) }

        it { is_expected.to be true }
      end
    end
  end
end
