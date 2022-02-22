# frozen_string_literal: true

RSpec.describe AASMMermaid::Diagram do
  subject(:diagram) { described_class.new(aasm: TestAASMParentClass.aasm) }

  describe '#generate' do
    let(:expected_diagram_string) do
      <<~STRING
        stateDiagram-v2
          sleeping --> running : run
          running --> cleaning : clean
          running --> sleeping : sleep
          cleaning --> sleeping : sleep
          sleeping --> sleeping : procrastinate
          running --> sleeping : procrastinate
          cleaning --> sleeping : procrastinate
      STRING
    end

    it 'generates the diagram' do
      expect(diagram.generate).to eq(expected_diagram_string.strip)
    end
  end
end
