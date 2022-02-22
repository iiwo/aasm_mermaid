# frozen_string_literal: true

require 'aasm_mermaid'
require 'aasm'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    class TestAASMParentClass
      include AASM
      attr_accessor :state

      aasm do
        state :sleeping, initial: true
        state :running, :cleaning

        event :run do
          transitions from: :sleeping, to: :running
        end

        event :clean do
          transitions from: :running, to: :cleaning
        end

        event :sleep do
          transitions from: %i[running cleaning], to: :sleeping
        end

        event :procrastinate do
          transitions to: :sleeping
        end
      end
    end
  end
end
