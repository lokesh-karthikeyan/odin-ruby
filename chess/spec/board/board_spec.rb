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

  describe '.place_pieces' do
    let(:new_board) { board.create }

    context 'When the "FEN" string -> rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' do
      let(:fen_formatted_board) do
        [
          ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
          ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'],
          ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R']
        ]
      end
      let(:result) { board.place_pieces(fen_formatted_board, new_board) }

      context 'When the first row is placed with pieces' do
        subject { result[0].map { |place| [place.piece.type, place.piece.color] } }
        first_row_piece_types = [
          %i[Rook black], %i[Knight black], %i[Bishop black], %i[Queen black],
          %i[King black], %i[Bishop black], %i[Knight black], %i[Rook black]
        ]

        it { is_expected.to eq(first_row_piece_types) }
      end

      context 'When the second row is placed with pieces' do
        subject { result[1].map { |place| [place.piece.type, place.piece.color] } }
        second_row_piece_types = [
          %i[Pawn black], %i[Pawn black], %i[Pawn black], %i[Pawn black],
          %i[Pawn black], %i[Pawn black], %i[Pawn black], %i[Pawn black]
        ]

        it { is_expected.to eq(second_row_piece_types) }
      end

      context 'When the third, fourth, fifth, sixth row is placed with pieces' do
        let(:third_row) { result[2].map { |place| [place.piece.type, place.piece.color] } }
        let(:fourth_row) { result[3].map { |place| [place.piece.type, place.piece.color] } }
        let(:fifth_row) { result[4].map { |place| [place.piece.type, place.piece.color] } }
        let(:sixth_row) { result[5].map { |place| [place.piece.type, place.piece.color] } }

        subject { third_row + fourth_row + fifth_row + sixth_row }

        null_piece_types = [
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', '']
        ]

        it { is_expected.to eq(null_piece_types) }
      end

      context 'When the seventh row is placed with pieces' do
        subject { result[6].map { |place| [place.piece.type, place.piece.color] } }
        seventh_row_piece_types = [
          %i[Pawn white], %i[Pawn white], %i[Pawn white], %i[Pawn white],
          %i[Pawn white], %i[Pawn white], %i[Pawn white], %i[Pawn white]
        ]

        it { is_expected.to eq(seventh_row_piece_types) }
      end

      context 'When the eighth row is placed with pieces' do
        subject { result[7].map { |place| [place.piece.type, place.piece.color] } }
        eighth_row_piece_types = [
          %i[Rook white], %i[Knight white], %i[Bishop white], %i[Queen white],
          %i[King white], %i[Bishop white], %i[Knight white], %i[Rook white]
        ]

        it { is_expected.to eq(eighth_row_piece_types) }
      end
    end

    context 'When the "FEN" string -> r4bnr/ppp1k1pp/n3b3/3qP1N1/1P2P3/2N4B/PBP1KPR1/R6r' do
      let(:fen_formatted_board) do
        [
          ['r', ' ', ' ', ' ', ' ', 'b', 'n', 'r'],
          ['p', 'p', 'p', ' ', 'k', ' ', 'p', 'p'],
          ['n', ' ', ' ', ' ', 'b', ' ', ' ', ' '],
          [' ', ' ', ' ', 'q', 'P', ' ', 'N', ' '],
          [' ', 'P', ' ', ' ', 'P', ' ', ' ', ' '],
          [' ', ' ', 'N', ' ', ' ', ' ', ' ', 'B'],
          ['P', 'B', 'P', ' ', 'K', 'P', 'R', ' '],
          ['R', ' ', ' ', ' ', ' ', ' ', ' ', 'r']
        ]
      end
      let(:result) { board.place_pieces(fen_formatted_board, new_board) }

      context 'When the first, second, third, fourth row is placed with pieces' do
        let(:first_row) { result[0].map { |place| [place.piece.type, place.piece.color] } }
        let(:second_row) { result[1].map { |place| [place.piece.type, place.piece.color] } }
        let(:third_row) { result[2].map { |place| [place.piece.type, place.piece.color] } }
        let(:fourth_row) { result[3].map { |place| [place.piece.type, place.piece.color] } }

        subject { first_row + second_row + third_row + fourth_row }

        first_four_rows = [
          %i[Rook black], ['', ''], ['', ''], ['', ''], ['', ''], %i[Bishop black], %i[Knight black], %i[Rook black],
          %i[Pawn black], %i[Pawn black], %i[Pawn black], ['', ''], %i[King black], ['', ''], %i[Pawn black],
          %i[Pawn black],
          %i[Knight black], ['', ''], ['', ''], ['', ''], %i[Bishop black], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], ['', ''], %i[Queen black], %i[Pawn white], ['', ''], %i[Knight white], ['', '']
        ]

        it { is_expected.to eq(first_four_rows) }
      end

      context 'When the fifth, sixth, seventh, eighth row is placed with pieces' do
        let(:fifth_row) { result[4].map { |place| [place.piece.type, place.piece.color] } }
        let(:sixth_row) { result[5].map { |place| [place.piece.type, place.piece.color] } }
        let(:seventh_row) { result[6].map { |place| [place.piece.type, place.piece.color] } }
        let(:eighth_row) { result[7].map { |place| [place.piece.type, place.piece.color] } }

        subject { fifth_row + sixth_row + seventh_row + eighth_row }

        last_four_rows = [
          ['', ''], %i[Pawn white], ['', ''], ['', ''], %i[Pawn white], ['', ''], ['', ''], ['', ''],
          ['', ''], ['', ''], %i[Knight white], ['', ''], ['', ''], ['', ''], ['', ''], %i[Bishop white],
          %i[Pawn white], %i[Bishop white], %i[Pawn white], ['', ''], %i[King white], %i[Pawn white],
          %i[Rook white], ['', ''],
          %i[Rook white], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], %i[Rook black]
        ]

        it { is_expected.to eq(last_four_rows) }
      end
    end

    context 'When the "FEN" string -> 7N/1b3RN1/7k/6b1/KBp4p/5q2/6Q1/7n' do
      let(:fen_formatted_board) do
        [
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'N'],
          [' ', 'b', ' ', ' ', ' ', 'R', 'N', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'k'],
          [' ', ' ', ' ', ' ', ' ', ' ', 'b', ' '],
          ['K', 'B', 'p', ' ', ' ', ' ', ' ', 'p'],
          [' ', ' ', ' ', ' ', ' ', 'q', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', 'Q', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'n']
        ]
      end
      let(:result) { board.place_pieces(fen_formatted_board, new_board) }

      context 'When the first, second, third, fourth row is placed with pieces' do
        let(:first_row) { result[0].map { |place| [place.piece.type, place.piece.color] } }
        let(:second_row) { result[1].map { |place| [place.piece.type, place.piece.color] } }
        let(:third_row) { result[2].map { |place| [place.piece.type, place.piece.color] } }
        let(:fourth_row) { result[3].map { |place| [place.piece.type, place.piece.color] } }

        subject { first_row + second_row + third_row + fourth_row }

        first_four_rows = [
          ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], %i[Knight white],
          ['', ''], %i[Bishop black], ['', ''], ['', ''], ['', ''], %i[Rook white], %i[Knight white], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], %i[King black],
          ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], %i[Bishop black], ['', '']
        ]

        it { is_expected.to eq(first_four_rows) }
      end

      context 'When the fifth, sixth, seventh, eighth row is placed with pieces' do
        let(:fifth_row) { result[4].map { |place| [place.piece.type, place.piece.color] } }
        let(:sixth_row) { result[5].map { |place| [place.piece.type, place.piece.color] } }
        let(:seventh_row) { result[6].map { |place| [place.piece.type, place.piece.color] } }
        let(:eighth_row) { result[7].map { |place| [place.piece.type, place.piece.color] } }

        subject { fifth_row + sixth_row + seventh_row + eighth_row }

        last_four_rows = [
          %i[King white], %i[Bishop white], %i[Pawn black], ['', ''], ['', ''], ['', ''], ['', ''], %i[Pawn black],
          ['', ''], ['', ''],  ['', ''], ['', ''], ['', ''], %i[Queen black], ['', ''], ['', ''],
          ['', ''], ['', ''],  ['', ''], ['', ''], ['', ''], ['', ''], %i[Queen white], ['', ''],
          ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], ['', ''], %i[Knight black]
        ]

        it { is_expected.to eq(last_four_rows) }
      end
    end
  end

  describe '.update_pieces' do
    let(:board_state) { board.create }

    context 'When given a source spot & target spot' do
      before do
        board_state[1][1].piece.type = :Pawn
        board_state[1][1].piece.color = :black
        board_state[1][1].piece.icon = ' ♟ '
      end
      let(:source) { [1, 1] }
      let(:target) { [3, 1] }

      it "should update the source spot's attributes to the target spot's attributes" do
        expect { board.update_pieces(source, target) }
          .to change { board_state[3][1].piece.type }.from('').to(:Pawn)
          .and change { board_state[3][1].piece.color }.from('').to(:black)
          .and change { board_state[3][1].piece.icon }.from('').to(' ♟ ')
      end

      it 'should change the source spot to null piece' do
        expect { board.update_pieces(source, target) }
          .to change { board_state[1][1].piece.type }.from(:Pawn).to('')
          .and change { board_state[1][1].piece.color }.from(:black).to('')
          .and change { board_state[1][1].piece.icon }.from(' ♟ ').to('')
      end
    end
  end
end
