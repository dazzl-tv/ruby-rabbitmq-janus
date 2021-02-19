# frozen_string_literal: true

require 'logger'
require 'rrj/info'
require 'rrj/tools/gem/config'

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # @since 2.6.0
    #
    # # Manage log in this gem
    #
    # Create module for managing logger in many level.
    # In Thread process.
    # In rails apps (final app use this gem).
    #
    # Prepare different output :
    # STDOUT
    # RemoteSyslogger (for papertrail)
    # File
    module Logger
      # Write basic information about this gem
      def self.start
        Log.info '### Start bin Ruby Rabbit Janus ###'
        Log.info "Program : #{RubyRabbitmqJanus::Tools::Config.instance.pg}"
        Log.info "RRJ Version : #{RubyRabbitmqJanus::VERSION}"
        Log.debug "\r\n#{RubyRabbitmqJanus::BANNER}"
      end

      # Configure logger used by RRJ
      def self.create
        @config = RubyRabbitmqJanus::Tools::Config.instance

        @log = initialize_logger
        @log.level = @config.log_level

        @log
      end

      # Choose type logger used in application instance
      def self.initialize_logger
        case @config.log_type
        when :file    then logger_file
        when :remote  then logger_remote
        else
          logger_stdout
        end
      end

      # Configure logger with output SDTOUT
      def self.logger_stdout
        ::Logger.new($stdout)
      end

      # Configure logger with output file
      # default : `log/ruby-rabbitmq-janus.log`
      def self.logger_file
        ::Logger.new(@config.log_option || 'log/ruby-rabbitmq-janus.log')
      end

      # Configure logger with output PaperTrail service
      def self.logger_remote
        require 'remote_syslog_logger'

        RemoteSyslogLogger.new(remote_url,
                               remote_port,
                               program: remote_program,
                               local_hostname: remote_hostname)
      end

      # Read url for PaperTail and split for endpoint
      def self.remote_url
        @config.log_option.split(':').first
      end

      # Read url for PaperTrail and split for port
      def self.remote_port
        @config.log_option.split('@').first.split(':').last
      end

      # Read url for PaperTrail and split for name app
      def self.remote_program
        @config.log_option.split('@').last.split(':').first
      end

      # Read url for PaperTrail and split for host
      def self.remote_hostname
        @config.log_option.split(':').last
      end
    end
  end
end
