# frozen_string_literal: true

# Load gem Config if present
# @see https://rubygems.org/gems/config

begin
  require 'config'

  if defined?(Config)
    config_conf = [
      File.join(Dir.pwd, 'config', 'settings.yml'),
      File.join(Dir.pwd, 'config', 'settings', "#{ENV['RAILS_ENV']}.yml")
    ]
    Config.load_and_set_settings(config_conf)
  end
rescue LoadError => exception
  puts 'Custom configuration is not present,' \
       " use default configuration. (#{exception})"
rescue StandardError => exception
  puts exception
end
