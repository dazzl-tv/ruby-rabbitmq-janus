# frozen_string_literal: true

require 'yaml'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Loading a yaml file for apply a configuration to gem.
  # @!attribute [r] options
  #   @return  [RRJ::Config] Options to gem.
  class Config
    attr_reader :options

    # Define a default path to file configuration
    DEFAULT_PATH = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))

    FILE_CONF = 'config/default.yml'

    # Define a default name to file configuration
    DEFAULT_CONF = File.join(DEFAULT_PATH, FILE_CONF)

    # Define a default override file configuration
    CUSTOMIZE_CONF = 'config/ruby-rabbitmq-janus.yml'

    # Initialize configuration file default or customize if exist
    # @param logs [RRJ::Log] Load RRJ::Log to gem
    def initialize(logs)
      @logs = logs
      @options = load_configuration(DEFAULT_CONF)
      override_configuration(File.join(Dir.pwd, CUSTOMIZE_CONF))
    end

    private

    # Load configuration file yaml
    # @param file [String] Path to configuration file (with name)
    # @return [Yaml] Configuration file
    def load_configuration(file)
      @logs.info("Loading configuration file : #{file}")
      YAML.load(File.read(file))
    end

    # Load customize configuration file if exist
    # @return [Yaml] Configuration file
    # @param file [String] Path to configuration file (with name)
    def override_configuration(file)
      @options = load_configuration(file) if File.exist?(file)
    end
  end
end
