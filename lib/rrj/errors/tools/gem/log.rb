# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Tools
      class BaseLog < BaseTools
        def initialize(message, level = :warn)
          super("[Log]#{message}", level)
        end
      end

      module Log
        class Unknown < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Unknown] Error for writing in logger with level :unknown'
          end
        end

        # Error for Tools::Log#fatal
        class Fatal < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Fatal] Error for writing in logger with level :fatal'
          end
        end

        # Error for Tools::Log#error
        class Error < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Error] Error for writing in logger with level :error'
          end
        end

        # Error for Tools::Log#warn
        class Warn < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Warn] Error for writing in logger with level :warning'
          end
        end

        # Error for Tools::Log#info
        class Info < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Info] Error for writing in logger with level :nfo'
          end
        end

        # Error for Tools::Log#debug
        class Debug < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Debug] Error for writing in logger with level :debug'
          end
        end

        # Error for Tools::Log#logger
        class Logger < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Logger] Error return logger to instance'
          end
        end

        # Error for Tools::Log#logdev
        class Logdev < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[Logdev] Error filname to logger instance'
          end
        end

        # Error for Tools::Log#save_level
        class SaveLevel < RubyRabbitmqJanus::Errors::Tools::BaseLog
          def initialize
            super '[SaveLevel] Error for changing log level'
          end
        end
      end
    end
  end
end
