# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage log in this gem
    #
    # Singleton object for manipulate logs in this gem
    #
    # @!attribute [r] level
    #   @return [Fixnum] Return a number to log level.
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

      # Sensitive data
      SENSITIVES = %i(admin_secret apisecret).freeze

      attr_reader :level

      # Returns a new instance to Log and use `Tag` element for each line
      # writing in log with name to gem.
      #
      # @see http://api.rubyonrails.org/classes/ActiveSupport/TaggedLogging.html
      def initialize
        logs = defined?(Rails) ? logger_rails : logger_develop
        logs.progname = RubyRabbitmqJanus.name
        logs.level = LEVELS[:DEBUG]
        logs.info('### Start gem Rails Rabbit Janus ###')
        @level = logs.level
        @progname = logs.progname
        @logs = ActiveSupport::TaggedLogging.new(logs)
      rescue
        raise Errors::Tools::Log::Initializer
      end

      # Write a message in log with a `UNKNOWN` level
      #
      # @param message [String] Message writing in warning level in log
      def unknown(message)
        write_tag { @logs.unknown(filter(message)) }
      rescue
        raise Errors::Tools::Log::Unknow
      end

      # Write a message in log with a `FATAL` level
      #
      # @param message [String] Message writing in warning level in log
      def fatal(message)
        write_tag { @logs.fatal(filter(message)) } if test_level?(Logger::FATAL)
      rescue
        raise Errors::Tools::Log::Fatal
      end

      # Write a message in log with a `ERROR` level
      #
      # @param message [String] Message writing in warning level in log
      def error(message)
        write_tag { @logs.error(filter(message)) } if test_level?(Logger::ERROR)
      rescue
        raise Errors::Tools::Log::Error
      end

      # Write a message in log with a `WARN` level
      # @param message [String] Message writing in warning level in log
      def warn(message)
        write_tag { @logs.warn(filter(message)) } if test_level?(Logger::WARN)
      rescue
        raise Errors::Tools::Log::Warn
      end

      # Write a message in log with a `INFO` level
      #
      # @param message [String] Message writing in info level in log
      def info(message)
        write_tag { @logs.info(filter(message)) } if test_level?(Logger::INFO)
      rescue
        raise Errors::Tools::Log::Info
      end

      # Write a message in log with a `DEBUG` level
      #
      # @param message [String] Message writing in debug level in log
      def debug(message)
        write_tag { @logs.debug(filter(message)) } if test_level?(Logger::DEBUG)
      rescue
        raise Errors::Tools::Log::Debug
      end

      # @return [RubyRabbitmqJanus::Tools::Log] the instance to logger
      def logger
        @logs
      rescue
        raise Errors::Tools::Log::Logger
      end

      # @return [String] name of file to logger used
      def logdev
        @logs.instance_variable_get(:'@logdev').filename
      rescue
        raise Errors::Tools::Log::Logdev
      end

      # Save log level used in this gem
      #
      # @param [Symbol] gem_level Level used for log in this gem
      def save_level(gem_level)
        @level = LEVELS[gem_level]
      rescue
        raise Errors::Tools::Log::SaveLevel
      end

      private

      def logger_rails
        Rails.logger
      end

      def logger_develop
        log = Logger.new('log/rails-rabbit-janus.log')
        log.formatter = proc do |severity, _datetime, _progname, msg|
          "#{severity[0, 1].upcase}, #{msg}\n"
        end
        log
      end

      def test_level?(this_level)
        this_level >= Log.instance.level ? true : false
      end

      def write_tag
        @logs.tagged(@logs.progname) { yield }
      end

      # @todo fix replace
      def filter_sensitive_data(log)
        msg = log
        SENSITIVES.each do |word|
          msg = log.gsub(/\"#{word}\".*\".*\"/, "\"#{word}\":\"[FILTERED]\"") \
            if log.include?(word.to_s)
        end
        msg
      end

      alias filter filter_sensitive_data
    end
  end
end
