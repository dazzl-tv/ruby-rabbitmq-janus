# frozen_string_literal: true

# rubocop:disable Naming/MemoizedInstanceVariableName
module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage configuration file
    # Singleton object for reading configuration file
    #
    # @!attribute [r] options
    #   @return [Hash] Return all options to configured in config file.
    # @!attribute [r] configuration
    #   @return [String] Path to configuration file used
    class Config
      include Singleton

      attr_reader :options, :configuration

      # Define HOME RRJ gem
      RRJ_HOME = File.realpath(File.join(File.dirname(__FILE__),
                                         '..', '..', '..'))

      # Define a default name to file configuration
      CONF_DEFAULT = 'config/default.yml'

      # Define a default override file configuration
      CONF_CUSTOM = 'config/ruby-rabbitmq-janus.yml'

      # Define a default path to file configuration to gem
      PATH_DEFAULT = File.join(RRJ_HOME, CONF_DEFAULT)

      # Initialize configuration file default or customize if exist
      def initialize
        @options = @configuration = nil
        loading_configuration_customize
        loading_configuration_default
        Tools::Log.instance.save_level(log_level)
      rescue
        raise Errors::Tools::Config::Initialize
      end

      # Get to name queue_from (pattern)
      #
      # @return [String] read configuration for queue `from`
      def queue_from
        @options['queues']['standard']['from'].to_s
      rescue
        raise Errors::Tools::Config::QueueFrom
      end

      # Get to name queue_to (pattern)
      #
      # @return [String] read configuration for queue `to`
      def queue_to
        @options['queues']['standard']['to'].to_s
      rescue
        raise Errors::Tools::Config::QueueTo
      end

      # Get to name queue_admin_from (pattern)
      #
      # @return [String] read configuration for queue admin `from`
      def queue_admin_from
        @options['queues']['admin']['from'].to_s
      rescue
        raise Errors::Tools::Config::QueueAdminFrom
      end

      # Get to name queue_admin_from (pattern)
      #
      # @return [String] read configuration for queue admin `to`
      def queue_admin_to
        @options['queues']['admin']['to'].to_s
      rescue
        raise Errors::Tools::Config::QueueAdminTo
      end

      # @return [Symbol] read configuration for log level used in this gem
      def log_level
        @options['gem']['log']['level'].upcase.to_sym || :INFO
      rescue
        raise Errors::Tools::Config::LogLevel
      end

      def log_level_rabbit
        @options['rabbit']['level'].upcase.to_sym || :INFO
      rescue
        raise Errors::Tools::Config::LogLevelRabbit
      end

      # @return [Integer]
      #   read configuration for janus time to live for keepalive messages
      def time_to_live
        @options['janus']['session']['keepalive'].to_i || 50
      rescue
        raise Errors::Tools::Config::TimeToLive
      end

      alias ttl time_to_live

      # @param [Fixnum] index determine what field is readint in array plugins
      #   in configuration file
      # @return [String] read configuration for plugin with index
      def plugin_at(index = 0)
        @options['janus']['plugins'][index].to_s
      rescue
        raise Errors::Tools::Config::PluginAt, index
      end

      # @return [Boolean] Read option file for a janus cluster section
      def cluster
        @options['gem']['cluster']['enabled'].to_s.match?('true') ? true : false
      rescue
        raise Errors::Tools::Config::Cluster
      end

      private

      def load_configuration
        log_message = "Loading configuration file : #{@configuration}"
        Tools::Log.instance.info(log_message)
        YAML.safe_load(ERB.new(File.read(@configuration)).result)
      end

      def loading_configuration_customize
        @configuration = File.join(Dir.pwd, CONF_CUSTOM)
        @options = load_configuration if File.exist?(@configuration)
      end

      def loading_configuration_default
        @configuration = PATH_DEFAULT
        @options ||= load_configuration
      end
    end
  end
end
# rubocop:enable Naming/MemoizedInstanceVariableName
