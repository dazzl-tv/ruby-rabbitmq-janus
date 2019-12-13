# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      # Define a super class for all error in Process::Concurency class
      class BaseConcurency < RubyRabbitmqJanus::Errors::RRJError
        def initialize(message)
          super "[Concurency]#{message}", :fatal
        end
      end

      # Define a super class for all error in Process::Concurency::Event class
      class BaseEvent < RubyRabbitmqJanus::Errors::Process::BaseConcurency
        def initialize(class_name, message)
          super "[#{class_name}] #{message}"
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

require 'rrj/errors/process/event'
require 'rrj/errors/process/event_admin'
