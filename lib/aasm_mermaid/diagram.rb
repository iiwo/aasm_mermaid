# frozen_string_literal: true

module AASMMermaid
  # Mermaid diagram
  # @private
  class Diagram
    # @param aasm [AASM::Base] aasm instance
    def initialize(aasm:)
      self.aasm = aasm
    end

    # @return [String] Mermaid diagram string
    def generate
      "stateDiagram-v2\n#{transitions_string}"
    end

    private

      attr_accessor :aasm

      def events
        @events ||= aasm.events.map do |aasm_event|
          Event.new(aasm_event: aasm_event)
        end
      end

      def transitions
        events.map(&:transitions).flatten
      end

      def transitions_string
        transitions.map(&:to_diagram_string).join("\n")
      end
  end
end
