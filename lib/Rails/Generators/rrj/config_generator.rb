# frozen_string_literal: true

require 'rails/generators'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Generate a file for this gem
  class ConfigGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../../../config', __FILE__)

    desc 'This generator create a default config at config/ruby-rabbitmq-janus.yml'
    def create_config_file
      create_file 'config/ruby-rabbitmq-janus.yml', '# Add configuration to gem here'
    end
  end
end
