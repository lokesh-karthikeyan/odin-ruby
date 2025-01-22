# frozen_string_literal: true

require_relative '../../lib/state/state'

describe State do
  let(:state) { described_class }

  describe '.create_game_state' do
    context 'When this method is called' do
      subject { state.create_game_state }
      let(:result) { [[:check?, false], [:mate?, false], [:stale_mate?, false]] }
      let(:struct_contents) { [] }

      it { is_expected.to be_a(Struct) }

      it 'should contains { check?: false, mate?: false, stale_mate?: false }' do
        subject.each_pair { |name, value| struct_contents << [name, value] }

        expect(struct_contents).to eq(result)
      end
    end
  end

  describe '.create_move_state' do
    let(:movements) { [:white, true, true, true, true, '', 0, 0] }

    context 'When this method is called' do
      subject { state.create_move_state(movements) }
      let(:result) do
        [%i[active_color white], [:white_king_side_castle?, true], [:white_queen_side_castle?, true],
         [:black_king_side_castle?, true], [:black_queen_side_castle?, true], [:en_passant_target, ''],
         [:half_move_clock, 0], [:full_move_number, 0]]
      end
      let(:struct_contents) { [] }

      it { is_expected.to be_a(Struct) }

      it 'should create "Move State" with the given args' do
        subject.each_pair { |name, value| struct_contents << [name, value] }

        expect(struct_contents).to eq(result)
      end
    end
  end

  describe '.update_game_state' do
    let(:game_state) { state.create_game_state }

    context 'When the member name & value is given to update' do
      context 'with ":check?" is updated to be "true"' do
        it 'should change ":check?" to be true' do
          expect { state.update_game_state(:check?, true) }.to change { game_state.check? }.to be true
        end
      end

      context 'with ":mate?" is updated to be "true"' do
        it 'should change ":mate?" to be true' do
          expect { state.update_game_state(:mate?, true) }.to change { game_state.mate? }.to be true
        end
      end

      context 'with ":stale_mate?" is updated to be "true"' do
        it 'should change ":stale_mate?" to be true' do
          expect { state.update_game_state(:stale_mate?, true) }.to change { game_state.stale_mate? }.to be true
        end
      end
    end
  end

  describe '.update_move_state' do
    let(:movements) { [:white, true, true, true, true, '', 0, 0] }
    let(:move_state) { state.create_move_state(movements) }

    context 'When the member name & value is given to update' do
      context 'with ":active_color" is updated to be ":black"' do
        it 'should change ":active_color" to be ":black"' do
          expect { state.update_move_state(:active_color, :black) }.to change { move_state.active_color }.to eq(:black)
        end
      end

      context 'with ":white_king_side_castle?" is updated to be "false"' do
        it 'should change ":white_king_side_castle?" to be "false"' do
          expect { state.update_move_state(:white_king_side_castle?, false) }.to change {
            move_state.white_king_side_castle?
          }.to be false
        end
      end

      context 'with ":white_queen_side_castle?" is updated to be "false"' do
        it 'should change ":white_queen_side_castle?" to be "false"' do
          expect { state.update_move_state(:white_queen_side_castle?, false) }.to change {
            move_state.white_queen_side_castle?
          }.to be false
        end
      end

      context 'with ":black_king_side_castle?" is updated to be "false"' do
        it 'should change ":black_king_side_castle?" to be "false"' do
          expect { state.update_move_state(:black_king_side_castle?, false) }.to change {
            move_state.black_king_side_castle?
          }.to be false
        end
      end

      context 'with ":black_queen_side_castle?" is updated to be "false"' do
        it 'should change ":black_queen_side_castle?" to be "false"' do
          expect { state.update_move_state(:black_queen_side_castle?, false) }.to change {
            move_state.black_queen_side_castle?
          }.to be false
        end
      end

      context 'with ":en_passant_target" is updated to be "e6"' do
        it 'should change ":en_passant_target" to be "e6"' do
          expect { state.update_move_state(:en_passant_target, 'e6') }.to change {
            move_state.en_passant_target
          }.to be('e6')
        end
      end

      context 'with ":half_move_clock" is updated to be "46"' do
        it 'should change ":half_move_clock" to be "46"' do
          expect { state.update_move_state(:half_move_clock, 46) }.to change {
            move_state.half_move_clock
          }.to be(46)
        end
      end

      context 'with ":full_move_number" is updated to be "344"' do
        it 'should change ":full_move_number" to be "344"' do
          expect { state.update_move_state(:full_move_number, 344) }.to change {
            move_state.full_move_number
          }.to be(344)
        end
      end
    end
  end
end
