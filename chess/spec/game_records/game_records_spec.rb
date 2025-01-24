# frozen_string_literal: true

require_relative '../../lib/game_records/game_records'

describe GameRecords do
  let(:records) { described_class.new }

  describe '#log_board' do
    let(:last_state) { records.instance_variable_get(:@last_state) }
    let(:logs) { records.instance_variable_get(:@logs) }

    context 'When the method is called for the first time' do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      let(:result) { { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -' => 1 } }

      it 'should change "@logs" & "@last_state" variables' do
        records.log_board(fen_string)

        expect(last_state).to eq(fen_string)
        expect(logs).to include(result)
      end
    end

    context 'When adding a new board state' do
      before { records.log_board('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      let(:result) do
        { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -' => 1,
          'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3' => 1 }
      end

      it 'should update "@logs" & change "@last_state" variables' do
        records.log_board(fen_string)

        expect(last_state).to eq(fen_string)
        expect(logs).to include(result)
      end
    end

    context 'When adding an existing board state' do
      before do
        records.log_board('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
        records.log_board(fen_string)
      end
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      let(:result) do
        { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -' => 1,
          'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3' => 2 }
      end

      it 'should increment "@logs" & change "@last_state" variables' do
        records.log_board(fen_string)

        expect(last_state).to eq(fen_string)
        expect(logs).to include(result)
      end
    end

    context 'When adding a new board state while there are some existing states present' do
      before do
        records.log_board('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
        records.log_board('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1')
        records.log_board('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1')
      end
      let(:fen_string) { 'rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2' }
      let(:result) do
        { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -' => 1,
          'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3' => 2,
          'rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq -' => 1 }
      end

      it 'should update "@logs" & change "@last_state" variables' do
        records.log_board(fen_string)

        expect(last_state).to eq(fen_string)
        expect(logs).to include(result)
      end
    end
  end
end
