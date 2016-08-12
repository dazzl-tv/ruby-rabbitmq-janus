# frozen_string_literal: true

module RRJ
  # Configuration of gem
  module Config
    attr_reader :options

    DEFAULT_PATH = File.realpath(File.join(File.dirname(__FILE), '..', '..'))
    DEFAULT_CONF = File.join(DEFAULT_PATH, 'config', 'default.yml')
    CUSTOMIZE_CONF = ''
  end
end
