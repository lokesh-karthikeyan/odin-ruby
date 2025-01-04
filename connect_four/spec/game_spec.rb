# frozen_string_literal: true

require_relative '../lib/game/game'
require_relative '../lib/game_board/game_board'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new(player1, player2, game_board) }
  let(:player1) { double('Player', id: 1, name: 'Goku', disc: 'yellow') }
  let(:player2) { double('Player', id: 1, name: 'Vegeta', disc: 'red') }
  let(:game_board) { instance_double(GameBoard) }

  describe '#play' do
  end

  describe '#game_over?' do
    subject { game.game_over? }
    context 'When the "#won?" is "false", "#tie?" is "true"' do
      before do
        allow(game_board).to receive(:won?).and_return(false)
        allow(game_board).to receive(:tie?).and_return(true)
      end

      it { is_expected.to be true }
    end

    context 'When the "#won?" is "false", "#tie?" is "false"' do
      before do
        allow(game_board).to receive(:won?).and_return(false)
        allow(game_board).to receive(:tie?).and_return(false)
      end

      it { is_expected.not_to be true }
    end
  end

  describe '#valid_choice?' do
    context 'When choice is invalid' do
      choice = 10
      subject { game.valid_choice?(choice) }
      before { allow(game_board).to receive(:valid_position?).with(choice).and_return(true) }
      it { is_expected.not_to be true }
    end

    context 'When choice is valid, but column is full' do
      choice = 5
      subject { game.valid_choice?(choice) }
      before { allow(game_board).to receive(:valid_position?).with(choice).and_return(false) }
      it { is_expected.not_to be true }
    end

    context 'When choice is valid & also has free column space' do
      choice = 3
      subject { game.valid_choice?(choice) }
      before { allow(game_board).to receive(:valid_position?).with(choice).and_return(true) }
      it { is_expected.to be true }
    end
  end

  describe '#conclude_round' do
    context 'When the game is won' do
      round_result = { won: true, tie: false }
      before do
        game.instance_variable_set(:@result, round_result)
      end

      it 'should invoke "#round_is_won"' do
        expect(game).to receive(:round_is_won)
        game.conclude_round
      end
    end

    context 'When the game is tied' do
      round_result = { won: false, tie: true }
      before do
        game.instance_variable_set(:@result, round_result)
      end

      it 'should invoke "#round_is_tied"' do
        expect(game).to receive(:round_is_tied)
        game.conclude_round
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
