# frozen_string_literal: true

RSpec.describe AASMMermaid::Transition do
  subject(:transition) { described_class.new(from: from, to: to, event_name: event_name) }

  let(:from) { 'some_from' }
  let(:to) { 'some_to' }
  let(:event_name) { 'some_event_name' }

  describe '#==' do
    context 'when `from` `to` and `event_name` match' do
      let(:other) { described_class.new(from: from, to: to, event_name: event_name) }

      it 'returns true' do
        expect(transition == other).to eq(true)
      end
    end

    context 'when `from` does not match' do
      let(:other) { described_class.new(from: 'some_other_from', to: to, event_name: event_name) }

      it 'returns false' do
        expect(transition == other).to eq(false)
      end
    end

    context 'when `to` does not match' do
      let(:other) { described_class.new(from: from, to: 'some_other_to', event_name: event_name) }

      it 'returns false' do
        expect(transition == other).to eq(false)
      end
    end

    context 'when `event_name` does not match' do
      let(:other) { described_class.new(from: from, to: 'some_other_to', event_name: 'some_other_event_name') }

      it 'returns false' do
        expect(transition == other).to eq(false)
      end
    end
  end

  describe '#to_diagram_string' do
    it 'returns a Mermaid string for transition' do
      expect(transition.to_diagram_string).to eq('  some_from --> some_to : some_event_name')
    end
  end
end
