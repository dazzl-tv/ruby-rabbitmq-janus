# frozen_string_literal: true

require 'yaml'

module RubyRabbitmqJanus
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
    # :reek:UtilityFunction { public_methods_only: true }
    def load_configuration(file)
      Log.instance.info("Loading configuration file : #{file}")
      YAML.load(File.read(file))
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

    def define_log_level_used
      Log.instance.level = Log::LEVELS[@options['gem']['log']['level'].to_sym]
    end
  end
end
