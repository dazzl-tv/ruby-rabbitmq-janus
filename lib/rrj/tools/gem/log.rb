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
      def self.start
        Log.info '### Start bin Ruby Rabbit Janus ###'
        Log.info "RRJ Version : #{RubyRabbitmqJanus::VERSION}"
        Log.info "\r\n#{RubyRabbitmqJanus::BANNER}"
      end

      def self.create
        @config = RubyRabbitmqJanus::Tools::Config.instance

        @log = initialize_logger
        @log.level = @config.log_level

        @log
      end

      def self.initialize_logger
        case @config.log_type
        when :stdout  then logger_stdout
        when :file    then logger_file
        when :rails   then logger_rails
        when :remote  then logger_remote
        end
      end

      def self.logger_stdout
        ::Logger.new(STDOUT)
      end

      def self.logger_rails
        Rails.logger
      end

      def self.logger_file
        ::Logger.new('log/ruby-rabbitmq-janus.log')
      end

      def self.logger_remote
        RemoteSyslogLogger.new(remote_url,
                               remote_port,
                               program: remote_program,
                               local_hostname: remote_hostname)
      end

      def self.remote_url
        @config.log_option.split(':').first
      end

      def self.remote_port
        @config.log_option.split('@').first.split(':').last
      end

      def self.remote_program
        @config.log_option.split('@').last.split(':').first
      end

      def self.remote_hostname
        @config.log_option.split(':').last
      end
    end
  end
end
