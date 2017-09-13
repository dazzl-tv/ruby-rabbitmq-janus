# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency class
      class BaseConcurency < RubyRabbitmqJanus::Errors::BaseJanus
        def initialize(message)
          super "[Concurency]#{message}", :fatal
        end
      end

      module Concurency
        # Error for Janus::Concurency#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
          def initialize
            super 'Error initialize concurency class'
          end
        end
      end
    end
  end
end

require 'rrj/errors/janus/processus/keepalive'
require 'rrj/errors/janus/processus/event'
