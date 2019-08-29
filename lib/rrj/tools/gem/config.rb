# frozen_string_literal: true

require 'singleton'
require 'rrj/errors/error'
require 'yaml'
require 'erb'
require 'rrj/tools/gem/config/gem'
require 'rrj/tools/gem/config/rabbit'
require 'rrj/tools/gem/config/queues'
require 'rrj/tools/gem/config/janus'

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
      include RubyRabbitmqJanus::Tools::ConfigGem
      include RubyRabbitmqJanus::Tools::ConfigRabbit
      include RubyRabbitmqJanus::Tools::ConfigQueues
      include RubyRabbitmqJanus::Tools::ConfigJanus

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
      end

      private

      def load_configuration
        ::YAML.safe_load(ERB.new(File.read(@configuration)).result)
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
