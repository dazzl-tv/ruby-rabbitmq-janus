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

    # Define head for each line in log
    DEFAULT_HEAD_LOG = '[RRJ]'

    # Define a default level to gem
    DEFAULT_LEVEL = :info

    # Returns a new instance to Log
    def initialize
      @logs = Logging.logger[DEFAULT_HEAD_LOG]
      @logs.level = DEFAULT_LEVEL
      @logs.add_appenders Logging.appenders.file(DEFAULT_LOG_DIR + '/' + DEFAULT_LOG_NAME)

      @logs.write('====================================')
      @logs.write("\n")
      @logs.write('### Start gem Rails Rabbit Janus ###')
      @logs.write("\n")
      @logs.write('====================================')
      @logs.write("\n")
    end

    # Write a message in log file.
    # @param message [String] Message writing in logs
    # @param level [Symbol] Level to message (:info, :warn, :debug)
    def write(message, level = DEFAULT_LEVEL)
      msg = Time.now.strftime('%Y/%m/%d %H:%M:%S') + ' : ' + message
      case level
      when :info
        @logs.info msg
      when :warn
        @logs.warn msg
      end
    end
  end
end
