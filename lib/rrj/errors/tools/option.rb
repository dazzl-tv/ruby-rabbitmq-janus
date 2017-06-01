# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Option class
      class BaseOption < RRJError
        def initialize(message, level)
          super("[Option] #{message}", level)
        end
      end

      module Option
        # Error for Tools::Option#new
        class Initializer < RubyRabbitmqJanus::Errors::Tools::BaseOption
          def initialize(msg)
            super "Error in initializer : #{msg}", :fatal
          end
        end

        # Error for Tools::Option#use_current_session?
        class UseCurrentSession < RubyRabbitmqJanus::Errors::Tools::BaseOption
          def initialize(opts)
            super "Error for test use current session -- #{opts}", :fatal
          end
        end

        # Error for Tools::Option#use_current_handle?
        class UseCurrentHandle < RubyRabbitmqJanus::Errors::Tools::BaseOption
          def initialize(opts)
            super "Error for test use current handle -- #{opts}", :fatal
          end
        end
      end
    end
  end
end
