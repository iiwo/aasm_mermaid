# frozen_string_literal: true

require_relative 'aasm_mermaid/version'
require_relative 'aasm_mermaid/transition'
require_relative 'aasm_mermaid/event'
require_relative 'aasm_mermaid/diagram'

# Mermaid diagrams from AASM state machines
#
# @example generate a Mermaid diagram
#   AASMMermaid.generate_diagram_for(aasm: SomeClass.aasm)
#
module AASMMermaid
  # @param aasm [AASM::Base] aasm instance
  # @return [String] Mermaid diagram string
  def self.generate_diagram_for(aasm:)
    Diagram.new(aasm: aasm).generate
  end
end
