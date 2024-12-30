# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#update_grids' do
    let(:game_board) { board.instance_variable_get(:@game_board) }

    context 'When the place holder is 6, character is "X"' do
      it 'changes the 6th position with "X"' do
        number = 6
        character = 'X'
        board.update_grids(number, character)
        expect(game_board).to eq([' ', ' ', ' ', ' ', ' ', 'X', ' ', ' ', ' '])
      end
    end

    context 'When the place holder is 1, character is "O"' do
      it 'changes the 1st position with "O"' do
        number = 1
        character = 'O'
        board.update_grids(number, character)
        expect(game_board).to eq(['O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
      end
    end
  end
end
