# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define super class for all errors in Log class
      class BaseLog < RRJError
        def initialize(message, level = :warn)
          super("[Log] #{message}", level)
        end
      end

      module Log
        # Error for Tools::Log#new
        class Initializer < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error in initializer', :fatal
          end
        end

        class Unknow < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :unknown'
          end
        end

        class Fatal < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :fatal'
          end
        end

        class Error < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :error'
          end
        end

        class Warn < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :warning'
          end
        end

        class Info < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :nfo'
          end
        end

        class Debug < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :debug'
          end
        end

        class Logger < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error return logger to instance'
          end
        end

        class Logdev < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error filname to logger instance'
          end
        end

        class SaveLevel < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for changing log level'
          end
        end
      end
    end
  end
end
