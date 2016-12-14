# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage configuration file
    # Singleton object for reading configuration file
    #
    # @!attribute [r] options
    #   @return [Hash] Return all options to configured in config file.
    class Config
      include Singleton

      attr_reader :options

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
        @options = nil
        conf_customize
        conf_default
        Tools::Log.instance.save_level(log_level)
      end

      # @return [String] read configuration for queue `from`
      def queue_from
        @options['queues']['standard']['from']
      end

      # @return [String] read configuration for queue `to`
      def queue_to
        @options['queues']['standard']['to']
      end

      # @return [String] read configuration for queue admin `from`
      def queue_admin_from
        @options['queues']['admin']['from']
      end

      # @return [String] read configuration for queue admin `to`
      def queue_admin_to
        @options['queues']['admin']['to']
      end

      # @return [Symbol] read configuration for log lvel used in this gem
      def log_level
        @options['gem']['log']['level'].upcase.to_sym
      rescue
        raise Errors::LevelNotDefine
      end

      private

      def load_configuration(file)
        Tools::Log.instance.info("Loading configuration file : #{file}")
        YAML.load(ERB.new(File.read(file)).result)
      rescue
        raise Errors::ConfigFileNotFound, file
      end

      def conf_customize
        file = File.join(Dir.pwd, CONF_CUSTOM)
        @options = load_configuration(file) if File.exist?(file)
      end

      def conf_default
        file = PATH_DEFAULT
        @options ||= load_configuration(file)
      end
    end
  end
end
