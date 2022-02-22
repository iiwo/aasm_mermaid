# frozen_string_literal: true

module AASMMermaid
  # Handles AASM event mapping to diagram transition rows
  # @private
  class Event
    # @param [AASM::Event] aasm_event - AASM event to map
    def initialize(aasm_event:)
      self.aasm_event = aasm_event
    end

    # @return [Array<AASMMermaid::Transition>] array of mermaid transition rows
    def transitions
      return @transitions if @transitions

      @transitions = mapped_transitions
    end

    private

      attr_accessor :aasm_event

      def mapped_transitions
        aasm_transitions.map do |aasm_transition|
          transitions_for(aasm_transition: aasm_transition)
        end.flatten.uniq
      end

      def states
        aasm_event.state_machine.states.map(&:name)
      end

      def aasm_transitions
        aasm_event.transitions
      end

      # @param [Object] aasm_transition
      # @return [Array<AASMMermaid::Transition>]
      def transitions_for(aasm_transition:)
        if aasm_transition.from.nil?
          states.map do |state|
            Transition.new(from: state, to: aasm_transition.to.to_s, event_name: aasm_event.name)
          end
        else
          [Transition.new(from: aasm_transition.from.to_s, to: aasm_transition.to.to_s, event_name: aasm_event.name)]
        end
      end
  end
end
