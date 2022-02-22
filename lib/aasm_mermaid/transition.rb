# frozen_string_literal: true

module AASMMermaid
  # Represents a diagram transition row
  # @private
  class Transition
    attr_reader :from, :to, :event_name

    # @param [String, Symbol] from - from transition name
    # @param [String, Symbol] to - to transition name
    # @param [String, Symbol] event_name - transition event name
    def initialize(from:, to:, event_name:)
      self.from = from
      self.to = to
      self.event_name = event_name
    end

    # @return [true,false] true if given objet is equal, false otherwise
    def ==(other)
      from.to_s == other.from.to_s && to.to_s == other.to.to_s && event_name == other.event_name
    end

    # @return [String] mermaid diagram string
    def to_diagram_string
      "  #{from} --> #{to} : #{event_name}"
    end

    private

      attr_writer :from, :to, :event_name
  end
end
