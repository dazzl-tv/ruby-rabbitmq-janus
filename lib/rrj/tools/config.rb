# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Loading a yaml file for apply a configuration to gem.
    class Config
      include Singleton

      attr_reader :options

      # Define a default path to file configuration
      DEFAULT_PATH = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))

      # Define a default name to file configuration
      DEFAULT_CONF = 'config/default.yml'

      # Define a default override file configuration
      CUSTOMIZE_CONF = 'config/ruby-rabbitmq-janus.yml'

      # Initialize configuration file default or customize if exist
      def initialize
        @options = nil
        conf_customize
        conf_default
        define_log_level_used
      end

      private

      # Load configuration file yaml
      # @return [Yaml] Configuration file
      # @param file [String] Path to configuration file (with name)
      def load_configuration(file)
        Tools::Log.instance.info("Loading configuration file : #{file}")
        YAML.load(File.read(file))
      rescue
        raise Errors::ConfigFileNotFound, file
      end

      # Load customize configuration file if exist
      def conf_customize
        file = File.join(Dir.pwd, CUSTOMIZE_CONF)
        @options = load_configuration(file) if File.exist?(file)
      end

      # Load default configuration if customize configuration doesn't exist
      def conf_default
        file = File.join(DEFAULT_PATH, DEFAULT_CONF)
        @options ||= load_configuration(file)
      end

      # Define log lvel used in this gem
      def define_log_level_used
        Tools::Log.instance.level = \
          Tools::Log::LEVELS[@options['gem']['log']['level'].upcase.to_sym]
      rescue
        raise Errors::LevelNotDefine
      end
    end
  end
end
