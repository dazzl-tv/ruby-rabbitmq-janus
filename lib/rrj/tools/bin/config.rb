# frozen_string_literal: true

# Load gem config if present

begin
  require 'config'

  if defined?(Config)
    config_conf = [
      File.join(Dir.pwd, 'config', 'settings.yml'),
      File.join(Dir.pwd, 'config', 'settings', "#{ENVIRONMENT}.yml")
    ]
    Config.load_and_set_settings(config_conf)
  end
rescue LoadError => exception
  p 'Don\'t use gem config'
  p exception
end
