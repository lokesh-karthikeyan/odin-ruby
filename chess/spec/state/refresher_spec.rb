# frozen_string_literal: true

require_relative '../../lib/state/refresher'
require_relative '../../lib/state/state'

describe Refresher do
  let(:game_state) { State.create_game_state }
  let(:movements) { [:white, true, true, true, true, '-', 0, 1] }
  let(:move_state) { State.create_move_state(movements) }
  let(:refresher) { described_class.new(move_state, game_state) }

  describe '#switch_active_color' do
    context 'When the color -> "White"' do
      it 'should change "MoveState.active_color" -> "Black"' do
        expect { refresher.switch_active_color }.to change { move_state.active_color }.from(:white).to(:black)
      end
    end

    context 'When the color -> "Black"' do
      before { movements[0] = :black }

      it 'should change "MoveState.active_color" -> "White"' do
        expect { refresher.switch_active_color }.to change { move_state.active_color }.from(:black).to(:white)
      end
    end
  end

  describe '#disable_white_side_castling' do
    context 'When the values are "true"'  do
      it 'should change "MoveState.white_king_side_castle?" & "Move_state.white_queen_side_castle?" -> "false"' do
        expect { refresher.disable_white_side_castling }
          .to change { move_state.white_king_side_castle? }.from(true).to(false)
          .and change { move_state.white_queen_side_castle? }.from(true).to(false)
      end
    end

    context 'When the values are "false"' do
      before do
        movements[1] = false
        movements[2] = false
      end

      it 'should NOT change "MoveState.white_king_side_castle?" & "Move_state.white_queen_side_castle?"' do
        expect { refresher.disable_white_side_castling }
          .not_to change { move_state.white_king_side_castle? }.from(false)
        expect { refresher.disable_white_side_castling }
          .not_to change { move_state.white_queen_side_castle? }.from(false)
      end
    end
  end

  describe '#disable_black_side_castling' do
    context 'When the values are "true"' do
      it 'should change "MoveState.black_king_side_castle?" & "Move_state.black_queen_side_castle?" -> "false"' do
        expect { refresher.disable_black_side_castling }
          .to change { move_state.black_king_side_castle? }.from(true).to(false)
          .and change { move_state.black_queen_side_castle? }.from(true).to(false)
      end
    end

    context 'When the values are "false"' do
      before do
        movements[3] = false
        movements[4] = false
      end

      it 'should NOT change "MoveState.black_king_side_castle?" & "Move_state.black_queen_side_castle?"' do
        expect { refresher.disable_black_side_castling }
          .not_to change { move_state.black_king_side_castle? }.from(false)
        expect { refresher.disable_black_side_castling }
          .not_to change { move_state.black_queen_side_castle? }.from(false)
      end
    end
  end

  describe '#disable_white_king_side_castling' do
    context 'When the values are "true"' do
      it 'should change "MoveState.white_king_side_castle?" -> "false"' do
        expect { refresher.disable_white_king_side_castling }
          .to change { move_state.white_king_side_castle? }.from(true).to(false)
      end
    end

    context 'When the values are already "false"' do
      before { movements[1] = false }

      it 'should NOT change "MoveState.white_king_side_castle?"' do
        expect { refresher.disable_white_king_side_castling }
          .not_to change { move_state.white_king_side_castle? }.from(false)
      end
    end
  end

  describe '#disable_black_king_side_castling' do
    context 'When the value is "true"' do
      it 'should change "MoveState.black_king_side_castle?" -> "false"' do
        expect { refresher.disable_black_king_side_castling }
          .to change { move_state.black_king_side_castle? }.from(true).to(false)
      end
    end

    context 'When the value was already "false"' do
      before { movements[3] = false }

      it 'should NOT change "MoveState.black_king_side_castle?"' do
        expect { refresher.disable_black_king_side_castling }
          .not_to change { move_state.black_king_side_castle? }.from(false)
      end
    end
  end

  describe '#disable_white_queen_side_castling' do
    context 'When the value is "true"' do
      it 'should change "MoveState.white_queen_side_castle?" -> "false"' do
        expect { refresher.disable_white_queen_side_castling }
          .to change { move_state.white_queen_side_castle? }.from(true).to(false)
      end
    end

    context 'When the value was already "false"' do
      before { movements[2] = false }

      it 'should NOT change "MoveState.white_queen_side_castle?"' do
        expect { refresher.disable_white_queen_side_castling }
          .not_to change { move_state.white_queen_side_castle? }.from(false)
      end
    end
  end

  describe '#disable_black_queen_side_castling' do
    context 'When the value is "true"' do
      it 'should change "MoveState.black_queen_side_castle?" -> "false"' do
        expect { refresher.disable_black_queen_side_castling }
          .to change { move_state.black_queen_side_castle? }.from(true).to(false)
      end
    end

    context 'When the value was already "false"' do
      before { movements[4] = false }

      it 'should NOT change "MoveState.black_queen_side_castle?"' do
        expect { refresher.disable_black_queen_side_castling }
          .not_to change { move_state.black_queen_side_castle? }.from(false)
      end
    end
  end

  describe '#update_en_passant_target' do
    context 'When the spot label -> "-"' do
      let(:spot) { '-' }

      it 'should update "MoveState.en_passant_target" to "-"' do
        expect { refresher.update_en_passant_target(spot) }.not_to change { move_state.en_passant_target }.from('-')
      end
    end

    context 'When the spot label -> "d4"' do
      let(:spot) { 'd4' }

      it 'should update "MoveState.en_passant_target" to "d4"' do
        expect { refresher.update_en_passant_target(spot) }
          .to change { move_state.en_passant_target }.from('-').to('d4')
      end
    end
  end

  describe '#increment_half_move_clock' do
    it 'should increment "MoveState.half_move_clock"' do
      expect { refresher.increment_half_move_clock }.to change { move_state.half_move_clock }.by(1)
    end
  end

  describe '#reset_half_move_clock' do
    before { movements[6] = 45 }

    it 'should change "MoveState.half_move_clock" to "0"' do
      expect { refresher.reset_half_move_clock }.to change { move_state.half_move_clock }.from(45).to(0)
    end
  end

  describe '#increment_full_move_number' do
    it 'should increment "MoveState.full_move_number"' do
      expect { refresher.increment_full_move_number }.to change { move_state.full_move_number }.by(1)
    end
  end

  describe '#enable_check' do
    it 'should change "GameState.check?" -> "true"' do
      expect { refresher.enable_check }.to change { game_state.check? }.from(false).to(true)
    end
  end

  describe '#disable_check' do
    before { refresher.enable_check }

    it 'should change "GameState.check?" -> "false"' do
      expect { refresher.disable_check }.to change { game_state.check? }.from(true).to(false)
    end
  end

  describe '#enable_check_mate' do
    it 'should change "GameState.mate?" -> "true"' do
      expect { refresher.enable_check_mate }.to change { game_state.mate? }.from(false).to(true)
    end
  end

  describe '#enable_stale_mate' do
    it 'should change "GameState.stale_mate?" -> "true"' do
      expect { refresher.enable_stale_mate }.to change { game_state.stale_mate? }.from(false).to(true)
    end
  end
end
