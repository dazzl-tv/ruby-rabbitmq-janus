# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rrj/info'

Gem::Specification.new do |spec|
  spec.version       = if ENV['GITHUB_REF'].eql?('refs/heads/develop')
                         "#{RubyRabbitmqJanus::VERSION}" \
                           ".pre.#{ENV['GITHUB_RUN_ID']}"
                       else
                         RubyRabbitmqJanus::VERSION
                       end
  spec.name          = RubyRabbitmqJanus::GEM_NAME
  spec.authors       = RubyRabbitmqJanus::AUTHORS
  spec.email         = RubyRabbitmqJanus::EMAILS

  spec.summary       = RubyRabbitmqJanus::SUMMARY
  spec.description   = RubyRabbitmqJanus::DESCRIPTION

  spec.homepage      = RubyRabbitmqJanus::HOMEPAGE
  spec.license       = RubyRabbitmqJanus::LICENSE

  spec.files         = ['Gemfile', 'LICENSE', 'Rakefile', 'config/default.yml']
  spec.files         += ['README.md']
  spec.files         += ['config/default.md', 'config/requests.md']
  spec.files         += Dir['config/requests/admin/*']
  spec.files         += Dir['config/requests/base/*']
  spec.files         += Dir['config/requests/peer/*']
  spec.files         += Dir['lib/**/*']
  spec.files         += Dir['spec/**/*']
  spec.files         += Dir['tmp/**/*']

  spec.require_paths = ['lib']

  spec.post_install_message = RubyRabbitmqJanus::POST_INSTALL

  spec.bindir = 'bin'

  spec.executables << 'ruby_rabbitmq_janus'

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_development_dependency 'activerecord', '~> 6.1', '>= 6.1.3.1'
  spec.add_development_dependency 'appraisal', '~> 2.4'
  spec.add_development_dependency 'aruba', '~> 1.1'
  spec.add_development_dependency 'bigdecimal', '~> 3.0', '>= 3.0.2'
  spec.add_development_dependency 'database_cleaner', '~> 2.0', '>= 2.0.1'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'json-schema', '~> 2.8', '>= 2.8.1'
  spec.add_development_dependency 'json-schema-rspec', '~> 0.0.4'
  spec.add_development_dependency 'mongoid', '~> 7.2', '>= 7.2.2'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'rails', '~> 6.1', '>= 6.1.3.1'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  spec.add_development_dependency 'reek', '~> 6.0', '>= 6.0.4'
  spec.add_development_dependency 'remote_syslog_logger', '~> 1.0', '>= 1.0.4'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.13'
  spec.add_development_dependency 'rubocop-performance', '~> 1.11', '>= 1.11.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.3'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
  spec.add_development_dependency 'simplecov_json_formatter', '~> 0.1.3'
  spec.add_development_dependency 'sqlite3', '~> 1.4', '>= 1.4.2'
  spec.add_development_dependency 'yard', '~> 0.9.26'

  spec.add_runtime_dependency 'activesupport', '~> 6.1', '>= 6.1.3.1'
  spec.add_runtime_dependency 'bunny', '~> 2.17'
  spec.add_runtime_dependency 'key_path', '~> 1.2'
  spec.add_runtime_dependency 'parallel', '~> 1.20'
  spec.add_runtime_dependency 'semaphore', '~> 0.0.1'
  spec.add_runtime_dependency 'thread', '~> 0.2.2'
end
