# frozen_string_literal: true

require_relative '../../lib/board/board'

describe Board do
  let(:board) { described_class }

  describe '.create' do
    let(:result) { board.create }
    subject { result.flatten.size }

    it { is_expected.to eq(64) }

    context 'With first row has a label from (A8..H8)' do
      subject { result[0].map(&:label) }
      first_row = %w[A8 B8 C8 D8 E8 F8 G8 H8]

      it { is_expected.to eq(first_row) }
    end

    context 'With second row has a label from (A7..H7)' do
      subject { result[1].map(&:label) }
      second_row = %w[A7 B7 C7 D7 E7 F7 G7 H7]

      it { is_expected.to eq(second_row) }
    end

    context 'With third row has a label from (A6..H6)' do
      subject { result[2].map(&:label) }
      third_row = %w[A6 B6 C6 D6 E6 F6 G6 H6]

      it { is_expected.to eq(third_row) }
    end

    context 'With fourth row has a label from (A5..H5)' do
      subject { result[3].map(&:label) }
      fourth_row = %w[A5 B5 C5 D5 E5 F5 G5 H5]

      it { is_expected.to eq(fourth_row) }
    end

    context 'With fifth row has a label from (A4..H4)' do
      subject { result[4].map(&:label) }
      fifth_row = %w[A4 B4 C4 D4 E4 F4 G4 H4]

      it { is_expected.to eq(fifth_row) }
    end

    context 'With sixth row has a label from (A3..H3)' do
      subject { result[5].map(&:label) }
      sixth_row = %w[A3 B3 C3 D3 E3 F3 G3 H3]

      it { is_expected.to eq(sixth_row) }
    end

    context 'With seventh row has a label from (A2..H2)' do
      subject { result[6].map(&:label) }
      seventh_row = %w[A2 B2 C2 D2 E2 F2 G2 H2]

      it { is_expected.to eq(seventh_row) }
    end

    context 'With eighth row has a label from (A1..H1)' do
      subject { result[7].map(&:label) }
      eighth_row = %w[A1 B1 C1 D1 E1 F1 G1 H1]

      it { is_expected.to eq(eighth_row) }
    end
  end
end
