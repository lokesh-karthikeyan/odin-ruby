# frozen_string_literal: true

require_relative '../caesar_cipher'

describe '#caesar_cipher' do
  let(:string) { 'What a string!' }
  let(:shift_count) { 5 }

  context 'When the string is "What a string!", shift is 5' do
    it 'returns "Bmfy f xywnsl!"' do
      expect(caesar_cipher(string, shift_count)).to eq('Bmfy f xywnsl!')
    end
  end
end

describe '#to_ascii' do
  let(:string) { 'Hello!' }

  context 'When the string is "Hello!"' do
    it 'returns [72, 101, 108, 108, 111, 33]' do
      expect(to_ascii(string)).to eq([72, 101, 108, 108, 111, 33])
    end
  end
end

# rubocop:disable Metrics/BlockLength
describe '#shift_characters' do
  let(:shift_count) { 5 }

  context 'When the number is between "65..90" (or) "97..122"' do
    context 'When the number is 72, the shift is 5' do
      it 'returns 77' do
        number = 72
        expect(shift_characters(number, shift_count)).to eq(77)
      end
    end

    context 'When the number is 101, the shift is 5' do
      it 'returns 106' do
        number = 101
        expect(shift_characters(number, shift_count)).to eq(106)
      end
    end

    context 'When the number is 90, the shift is 5' do
      it 'returns 69' do
        number = 90
        expect(shift_characters(number, shift_count)).to eq(69)
      end
    end

    context 'When the number is 122, the shift is 5' do
      it 'returns 101' do
        number = 122
        expect(shift_characters(number, shift_count)).to eq(101)
      end
    end
  end

  context 'When the number is not between "65..90" and "97..122"' do
    context 'When the number is 33, the shift is 5' do
      it 'returns 33' do
        number = 33
        expect(shift_characters(number, shift_count)).to eq(33)
      end
    end

    context 'When the number is 180, the shift is 5' do
      it 'returns 180' do
        number = 180
        expect(shift_characters(number, shift_count)).to eq(180)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
