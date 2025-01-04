# frozen_string_literal: true

require_relative '../lib/player/player'

describe Player do
  context 'When given an id, a name & a disc' do
    subject(:player) { described_class.new(id, name, disc) }
    let(:id) { 1 }
    let(:name) { 'Goku' }
    let(:disc) { 'yellow' }

    it { is_expected.to be_a(Struct) }
  end
end
