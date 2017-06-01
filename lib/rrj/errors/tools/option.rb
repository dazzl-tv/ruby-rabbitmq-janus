# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Option class
      class BaseOption < RRJError
        def initialize(message, level)
          msg = "[Option] #{message} -- #{Tools::Log.instance.configuration}"
          super(msg, level)
        end
      end

      module Option
        # Error for Tools::Option#new
        class Initializer < RubyRabbitmqJanus::Error::Tools::BaseOption
          def initialize
            super 'Error in initializer', :fatal
          end
        end

        # Error for Tools::Option#use_current_session?
        class UseCurrentSession < RubyRabbitmqJanus::Error::Tools::BaseOption
          def initialize(opts)
            super "Error for test use current session -- #{opts}", :fatal
          end
        end

        # Error for Tools::Option#use_current_handle?
        class UseCurrentHandle < RubyRabbitmqJanus::Error::Tools::BaseOption
          def initialize(opts)
            super "Error for test use current handle -- #{opts}", :fatal
          end
        end
      end
    end
  end
end
