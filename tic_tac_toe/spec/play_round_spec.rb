# frozen_string_literal: true

require 'colorize'
require_relative '../lib/play_round'

# rubocop:disable Metrics/BlockLength
describe PlayRound do
  subject(:play_round) { described_class.new(board) }
  let(:board) { instance_double(Board) }

  describe '#inquire_player_choice' do
    context 'When invalid choice is entered for three times & valid choice at 4th time' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('d', '3', '%', 'x')
      end

      it 'returns "Invalid Selection"' do
        name = 'John Doe'
        invalid_phrase = 'Invalid Selection'.colorize(:red)
        expect(play_round).to receive(:puts).with(invalid_phrase).thrice
        play_round.inquire_player_choice(name)
      end
    end

    context 'When correct choice is entered' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('o')
      end

      it 'returns "O"' do
        name = 'Jane Doe'
        result = play_round.inquire_player_choice(name)
        expect(result).to eq('O')
      end
    end
  end

  describe '#inquire_place_holder' do
    let(:name) { 'Bruce Wayne' }
    let(:character) { 'O' }

    context 'When entered invalid (grid number / character) for 3 times' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('34', 'r', '$', '0', '1')
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
      end

      it 'returns "Invalid Selection"' do
        invalid_phrase = 'Invalid Selection'.colorize(:red)
        expect(play_round).to receive(:puts).with(invalid_phrase).exactly(4).times
        play_round.inquire_place_holder(name, character)
      end
    end

    context 'When entered a taken grid number for 3 times' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('1', '9', '5', '6')
        allow(play_round).to receive(:board_status).and_return(['X', ' ', ' ', ' ', 'O', ' ', ' ', ' ', 'X'])
      end

      it 'returns "Invalid Selection"' do
        invalid_phrase = 'Invalid Selection'.colorize(:red)
        expect(play_round).to receive(:puts).with(invalid_phrase).exactly(3).times
        play_round.inquire_place_holder(name, character)
      end
    end

    context 'When entered a valid grid number' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('8')
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
      end

      it 'returns "8"' do
        result = play_round.inquire_place_holder(name, character)
        expect(result).to eq(8)
      end
    end
  end

  describe '#start_game' do
    context "When the player enters a position to place 'X' or 'O'" do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('5')
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        allow(play_round).to receive(:possibilities).and_return([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                                                 [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]])
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        allow(play_round).to receive(:puts)
      end

      it 'sends a message to the board class' do
        expect(board).to receive(:update_grids).exactly(9).times
        play_round.start_game
      end
    end

    context 'When either of the player wins the match' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('5')
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        allow(board).to receive(:update_grids)
        allow(play_round).to receive(:show_board)
        allow(play_round).to receive(:won?).and_return(true)
        allow(play_round).to receive(:update_winner_profile)
        allow(play_round).to receive(:puts)
      end

      it 'invokes game_won() method' do
        expect(play_round).to receive(:game_won)
        play_round.start_game
      end
    end

    context 'When no one wins the match' do
      before do
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('5')
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        allow(board).to receive(:update_grids)
        allow(play_round).to receive(:show_board)
        allow(play_round).to receive(:won?).and_return(false)
      end

      it 'invokes game_lost() method' do
        expect(play_round).to receive(:game_lost)
        play_round.start_game
      end
    end
  end

  describe '#won?' do
    context 'When the "X" or "O" is not aligned?' do
      before do
        allow(play_round).to receive(:possibilities).and_return([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                                                 [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]])
        allow(play_round).to receive(:board_status).and_return([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
      end

      it 'returns false' do
        expect(play_round).not_to be_won
      end
    end

    context 'When the "X" or "O" is aligned?' do
      before do
        allow(play_round).to receive(:possibilities).and_return([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                                                 [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]])
        allow(play_round).to receive(:board_status).and_return([' ', ' ', 'X', ' ', ' ', 'X', ' ', ' ', 'X'])
      end

      it 'returns true' do
        expect(play_round).to be_won
      end
    end
  end

  describe '#continue_game?' do
    context 'When entered invalid characters for 3 times & valid one at last' do
      before do
        allow(play_round).to receive(:puts)
        allow(play_round).to receive(:print)
        allow(play_round).to receive(:gets).and_return('k', '6', '$', 'n')
      end

      it 'runs loop for 3 times' do
        invalid_phrase = 'Invalid Selection'.colorize(:red)
        expect(play_round).to receive(:puts).with(invalid_phrase).exactly(3).times
        play_round.continue_game?
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
