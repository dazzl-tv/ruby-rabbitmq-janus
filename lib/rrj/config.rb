# frozen_string_literal: true

require 'yaml'
require 'logging'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Loading a yaml file for apply a configuration to gem.
  # @!attribute [r] options
  #   @return  [RRJ::Config] Options to gem.
  # @!attribute [r] logs
  #   @return [RRJ::Log] Object instance to logs gem.
  class Config
    attr_reader :options, :logs

    # Define a default path to file configuration
    DEFAULT_PATH = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))

    # Define a default name to file configuration
    DEFAULT_CONF = File.join(DEFAULT_PATH, 'config', 'default.yml')

    # Define a default override file configuration
    CUSTOMIZE_CONF = '.rrj.yml'

    def initialize(logs)
      @logs = logs
      @options = load_configuration(DEFAULT_CONF)
      override_configuration(File.join(Dir.pwd, CUSTOMIZE_CONF))
    end

    private

    def load_configuration(file)
      @logs.write "Loading configuration file : #{file}"
      YAML.load(File.read(file))
    end

    def override_configuration(file)
      @options = load_configuration(file) if File.exist?(file)
    end
  end
end
