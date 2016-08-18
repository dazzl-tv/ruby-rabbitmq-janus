# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for wrtting logs. Define level used (:warn, :info, :debug).
  class Log
    include Singleton

    # Define folder to writing logs
    DEFAULT_LOG_DIR = 'log'

    # Define file name to writing logs
    DEFAULT_LOG_NAME = 'rails-rabbit-janus.log'

    # Define a default level to gem (:debug :info :warn :error :fatal :unknow)
    DEFAULT_LEVEL = :info

    # Returns a new instance to Log
    def initialize
      @logs = Logging.logger[Time.now.to_s + ' --']
      @logs.level = DEFAULT_LEVEL
      @logs.add_appenders Logging.appenders.file(DEFAULT_LOG_DIR + '/' + DEFAULT_LOG_NAME)

      welcome = \
        "====================================\n" \
        "### Start gem Rails Rabbit Janus ###\n" \
        "====================================\n"

      @logs.write(welcome)
    end

    # Write a message in log file.
    # @param message [String] Message writing in logs
    # @param level [Symbol] Level to message (:info, :warn, :debug)
    def write(message, level = DEFAULT_LEVEL)
      case level
      when :info
        @logs.info message
      when :warn
        @logs.warn message
      end
    end
  end
end
