# frozen_string_literal: true

RSpec.describe AASMMermaid::Event do
  subject(:event) { described_class.new(aasm_event: aasm_event) }

  def aasm_event_for(name:)
    TestAASMParentClass.aasm.events.find { |event| event.name.to_s == name.to_s }
  end

  describe '#transitions' do
    context 'with a single transition event' do
      let(:aasm_event) { aasm_event_for(name: 'run') }

      it 'returns transactions for event' do
        expect(event.transitions).to(
          eq(
            [
              AASMMermaid::Transition.new(from: 'sleeping', to: 'running', event_name: :run)
            ]
          )
        )
      end
    end

    context 'with a multiple transitions event' do
      let(:aasm_event) { aasm_event_for(name: 'sleep') }

      it 'returns transactions for event' do
        expect(event.transitions).to(
          eq(
            [
              AASMMermaid::Transition.new(from: 'running', to: 'sleeping', event_name: :sleep),
              AASMMermaid::Transition.new(from: 'cleaning', to: 'sleeping', event_name: :sleep)
            ]
          )
        )
      end
    end

    context 'with a catchall event' do
      let(:aasm_event) { aasm_event_for(name: 'procrastinate') }

      it 'returns transactions for event' do
        expect(event.transitions).to(
          eq(
            [
              AASMMermaid::Transition.new(from: 'sleeping', to: 'sleeping', event_name: :procrastinate),
              AASMMermaid::Transition.new(from: 'running', to: 'sleeping', event_name: :procrastinate),
              AASMMermaid::Transition.new(from: 'cleaning', to: 'sleeping', event_name: :procrastinate)
            ]
          )
        )
      end
    end
  end
end
