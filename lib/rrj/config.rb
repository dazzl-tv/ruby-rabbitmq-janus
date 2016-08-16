# frozen_string_literal: true

require 'yaml'
require 'logging'

module RRJ
  # Configuration of gem
  class Config
    attr_reader :options

    DEFAULT_PATH = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))
    DEFAULT_CONF = File.join(DEFAULT_PATH, 'config', 'default.yml')
    CUSTOMIZE_CONF = '.rrj.yml'

    def initialize
      @logs = Logging.logger['[RRJ]']
      @logs.level = :info
      @logs.add_appenders Logging.appenders.file('log/janus.log')

      @options = load_configuration(DEFAULT_CONF)
      override_configuration(File.join(Dir.pwd, CUSTOMIZE_CONF))
    end

    private

    def load_configuration(file)
      @logs.info 'Load configuration file :'
      @logs.info file
      YAML.load(File.read(file))
    end

    def override_configuration(file)
      @options = load_configuration(file) if File.exist?(file)
    end
  end
end
