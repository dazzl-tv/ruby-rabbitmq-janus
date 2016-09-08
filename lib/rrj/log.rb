# frozen_string_literal: true

require 'logging'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for wrtting logs. Define level used (:warn, :info, :debug).
  class Log
    include Singleton

    # Define folder to writing logs
    DEFAULT_LOG_DIR = 'log'

    # Define file name to writing logs
    DEFAULT_LOG_NAME = 'rails-rabbit-janus.log'

    # Define a default level to gem (:warn, :info, :debug)
    DEFAULT_LEVEL = :debug

    # Returns a new instance to Log
    def initialize
      @logs = Logging.logger[Time.now.to_s + ' --']
      @logs.level = DEFAULT_LEVEL
      @logs.add_appenders Logging.appenders.file(DEFAULT_LOG_DIR + '/' + DEFAULT_LOG_NAME)

      welcome = "\n"\
        "====================================\n" \
        "### Start gem Rails Rabbit Janus ###\n" \
        '===================================='
      @logs.info(welcome)
    end

    # Level to log
    # @return [Integer] The level to log instance
    def level
      @logs.level
    end

    # Save level to log
    # @param level [Symbol] Save log level used by this gem
    def level=(level)
      @logs.level = level
    end

    # Write a message in log with a warn level
    # @param message [String] Message writing in warning level in log
    def warn(message)
      @logs.warn(message)
    end

    # Write a message in log with a info level
    # @param message [String] Message writing in info level in log
    def info(message)
      @logs.info(message)
    end

    # Write a message in log with a debug level
    # @param message [String] Message writing in debug level in log
    def debug(message)
      @logs.debug(message)
    end
  end
end
