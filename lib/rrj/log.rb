# frozen_string_literal: true

require 'logging'

module RRJ
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

    def level
      @logs.level
    end

    def level=(level)
      @logs.level = level
    end

    # Write a message in log with a warn level
    def warn(message)
      @logs.warn(message)
    end

    # Write a message in log with a info level
    def info(message)
      @logs.info(message)
    end

    # Write a message in log with a debug level
    def debug(message)
      @logs.debug(message)
    end
  end
end
