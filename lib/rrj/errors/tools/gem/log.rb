# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define super class for all errors in Log class
      class BaseLog < BaseTools
        def initialize(message, level = :warn)
          super("[Log] #{message}", level)
        end
      end

      module Log
        # Error for Tools::Log#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error in initializer', :fatal
          end
        end

        # Error for Tools::Log#unknow
        class Unknow < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :unknown'
          end
        end

        # Error for Tools::Log#fatal
        class Fatal < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :fatal'
          end
        end

        # Error for Tools::Log#error
        class Error < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :error'
          end
        end

        # Error for Tools::Log#warn
        class Warn < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :warning'
          end
        end

        # Error for Tools::Log#info
        class Info < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :nfo'
          end
        end

        # Error for Tools::Log#debug
        class Debug < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for writing in logger with level :debug'
          end
        end

        # Error for Tools::Log#logger
        class Logger < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error return logger to instance'
          end
        end

        # Error for Tools::Log#logdev
        class Logdev < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error filname to logger instance'
          end
        end

        # Error for Tools::Log#save_level
        class SaveLevel < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super 'Error for changing log level'
          end
        end
      end
    end
  end
end
