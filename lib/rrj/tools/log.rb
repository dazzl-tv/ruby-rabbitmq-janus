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
    attr_accessor :level, :progname

    # Returns a new instance to Log
    def initialize
      logs = defined?(Rails) ? logger_rails : logger_develop
      logs.progname = RubyRabbitmqJanus.name
      logs.level = LEVELS[:DEBUG]
      logs.info('### Start gem Rails Rabbit Janus ###')
      @level = logs.level
      @progname = logs.progname
      @logs = ActiveSupport::TaggedLogging.new(logs)
    end

    # Write a message in log with a UNKNOWN level
    # @param message [String] Message writing in warning level in log
    def unknown(message)
      write_tag { @logs.unknown(message) }
    end

    # Write a message in log with a FATAL level
    # @param message [String] Message writing in warning level in log
    def fatal(message)
      write_tag { @logs.fatal(message) } if test_level?(Logger::FATAL)
    end

    # Write a message in log with a ERROR level
    # @param message [String] Message writing in warning level in log
    def error(message)
      write_tag { @logs.error(message) } if test_level?(Logger::ERROR)
    end

    # Write a message in log with a warn level
    # @param message [String] Message writing in warning level in log
    def warn(message)
      write_tag { @logs.warn(message) } if test_level?(Logger::WARN)
    end

    # Write a message in log with a info level
    # @param message [String] Message writing in info level in log
    def info(message)
      write_tag { @logs.info(message) } if test_level?(Logger::INFO)
    end

    # Write a message in log with a debug level
    # @param message [String] Message writing in debug level in log
    def debug(message)
      write_tag { @logs.debug(message) } if test_level?(Logger::DEBUG)
    end

    # Return instance logger
    def logger
      @logs
    end

    private

    # Define instance logger with rails
    def logger_rails
      Rails.logger
    end

    # Define instance logger wiptout rails
    def logger_develop
      log = Logger.new('log/rails-rabbit-janus.log')
      log.formatter = proc do |severity, _datetime, _progname, msg|
        "#{severity[0, 1].upcase}, #{msg}\n"
      end
      log
    end

    # This method smell :reek:UtilityFunction
    def test_level?(this_level)
      this_level >= Log.instance.level ? true : false
    end

    # Write a log with an tag
    def write_tag
      @logs.tagged(@logs.progname) { yield }
    end
  end
end
