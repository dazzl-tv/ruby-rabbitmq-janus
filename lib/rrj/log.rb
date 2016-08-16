# frozen_string_literal: true

module RRJ
  # Class for manipulate logs
  class Log
    attr_writer :log

    DEFAULT_LOG_DIR = 'log'
    DEFAULT_LOG_NAME = 'rails-rabbit-janus.log'
    DEFAULT_HEAD_LOG = '[RRJ]'
    DEFAULT_LEVEL = :info

    def initialize
      @logs = Logging.logger[DEFAULT_HEAD_LOG]
      @logs.level = DEFAULT_LEVEL
      @logs.add_appenders Logging.appenders.file(DEFAULT_LOG_DIR + '/' + DEFAULT_LOG_NAME)
    end

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
