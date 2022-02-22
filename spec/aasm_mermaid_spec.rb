# frozen_string_literal: true

RSpec.describe AASMMermaid do
  describe '.generate_diagram_for' do
    it 'calls Diagram#generate' do
      diagram_double = instance_double(AASMMermaid::Diagram, generate: 'a diagram')
      aasm = TestAASMParentClass.aasm

      expect(AASMMermaid::Diagram).to receive(:new).with(aasm: aasm).and_return(diagram_double)

      expect(AASMMermaid.generate_diagram_for(aasm: aasm)).to eq('a diagram')
    end
  end
end
