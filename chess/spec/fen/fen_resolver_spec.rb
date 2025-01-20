# frozen_string_literal: true

require_relative '../../lib/fen/fen_resolver'

describe FEN::FENResolver do
  describe '#resolve' do
    context "When 'FEN' string -> 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'" do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      let(:fen_resolver) { described_class.new(fen_string) }
      let(:result) do
        [
          [['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
           ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'],
           ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R']],

          [:white, true, true, true, true, '', 0, 1]
        ]
      end
      subject { fen_resolver.resolve }

      it { is_expected.to eq(result) }
    end

    context "When 'FEN' string -> 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1'" do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      let(:fen_resolver) { described_class.new(fen_string) }
      let(:result) do
        [
          [['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
           ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', 'P', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
           ['P', 'P', 'P', 'P', ' ', 'P', 'P', 'P'],
           ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R']],

          [:black, true, true, true, true, 'e3', 0, 1]
        ]
      end
      subject { fen_resolver.resolve }

      it { is_expected.to eq(result) }
    end

    context "When 'FEN' string -> '5k2/ppp5/4P3/3R3p/6P1/1K2Nr2/PP3P2/8 b - - 1 32'" do
      let(:fen_string) { '5k2/ppp5/4P3/3R3p/6P1/1K2Nr2/PP3P2/8 b - - 1 32' }
      let(:fen_resolver) { described_class.new(fen_string) }
      let(:result) do
        [
          [[' ', ' ', ' ', ' ', ' ', 'k', ' ', ' '],
           ['p', 'p', 'p', ' ', ' ', ' ', ' ', ' '],
           [' ', ' ', ' ', ' ', 'P', ' ', ' ', ' '],
           [' ', ' ', ' ', 'R', ' ', ' ', ' ', 'p'],
           [' ', ' ', ' ', ' ', ' ', ' ', 'P', ' '],
           [' ', 'K', ' ', ' ', 'N', 'r', ' ', ' '],
           ['P', 'P', ' ', ' ', ' ', 'P', ' ', ' '],
           [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']],

          [:black, false, false, false, false, '', 1, 32]
        ]
      end
      subject { fen_resolver.resolve }

      it { is_expected.to eq(result) }
    end
  end
end
