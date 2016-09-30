# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for wrtting logs.
  class Log
    include Singleton

    # Levels to log
    LEVELS = {
      DEBUG: Logger::DEBUG,
      INFO: Logger::INFO,
      WARN: Logger::WARN,
      ERROR: Logger::ERROR,
      FATAL: Logger::FATAL,
      UNKNOWN: Logger::UNKNOWN
    }.freeze

    # This method smell :reek:Attribute
    attr_accessor :level

    # Returns a new instance to Log
    def initialize
      @logs = defined?(Rails) ? Rails.logger : Logger.new('log/rails-rabbit-janus.log')
      @logs.progname = RubyRabbitmqJanus.name
      @logs.level = LEVELS[:DEBUG]
      @logs.info('### Start gem Rails Rabbit Janus ###')
      @level = @logs.level
    end

    # Write a message in log with a UNKNOWN level
    # @param message [String] Message writing in warning level in log
    def unknown(message)
      @logs.unknown(message)
    end

    # Write a message in log with a FATAL level
    # @param message [String] Message writing in warning level in log
    def fatal(message)
      @logs.fatal(message) if test_level?(Logger::FATAL)
    end

    # Write a message in log with a ERROR level
    # @param message [String] Message writing in warning level in log
    def error(message)
      @logs.error(message) if test_level?(Logger::ERROR)
    end

    # Write a message in log with a warn level
    # @param message [String] Message writing in warning level in log
    def warn(message)
      @logs.warn(message) if test_level?(Logger::WARN)
    end

    # Write a message in log with a info level
    # @param message [String] Message writing in info level in log
    def info(message)
      @logs.info(message) if test_level?(Logger::INFO)
    end

    # Write a message in log with a debug level
    # @param message [String] Message writing in debug level in log
    def debug(message)
      @logs.debug(message) if test_level?(Logger::DEBUG)
    end

    private

    # This method smell :reek:UtilityFunction
    def test_level?(this_level)
      this_level >= Log.instance.level ? true : false
    end
  end
end
