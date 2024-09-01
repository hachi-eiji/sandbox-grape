# frozen_string_literal: true

module Runners
  class TestRunners
    def self.run
      pp "test"
    end
  end
end

Runners::TestRunners.run if __FILE__ == $PROGRAM_NAME
