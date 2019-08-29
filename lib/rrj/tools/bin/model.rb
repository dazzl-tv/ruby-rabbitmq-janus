# frozen_string_literal: true

# Select ORM between Mongoid and ActiveRecord

require 'rrj/errors/error'
require RubyRabbitmqJanus::Tools::Config.instance.orm

# For mongoid gem
if RubyRabbitmqJanus::Tools::Config.instance.orm.eql?('mongoid')
  Mongoid.load!(File.join(Dir.pwd, 'config', 'mongoid.yml'),
                RubyRabbitmqJanus::Tools::Config.instance.env.to_sym)
end
