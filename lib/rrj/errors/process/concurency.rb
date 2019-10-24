# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      # Define a super class for all error in Process::Concurency class
      class BaseConcurency < RubyRabbitmqJanus::Errors::BaseJanus
        def initialize(message)
          super "[Concurency]#{message}", :fatal
        end
      end

      module Concurency
        # Error for Process::Concurency#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseConcurency
          def initialize
            super 'Error initialize concurency class'
          end
        end
      end
    end
  end
end

require 'rrj/errors/process/keepalive'
require 'rrj/errors/process/event'
