# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rrj/info'

Gem::Specification.new do |spec|
  version = RubyRabbitmqJanus::VERSION

  spec.name          = RubyRabbitmqJanus::GEM_NAME
  spec.authors       = RubyRabbitmqJanus::AUTHORS
  spec.email         = RubyRabbitmqJanus::EMAILS
  spec.version       = if ENV['TRAVIS'] && !ENV['TRAVIS_BRANCH'].eql?('master')
                         "#{version}-#{ENV['TRAVIS_BUILD_NUMBER']}"
                       else
                         version
                       end

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

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'json-schema'
  spec.add_development_dependency 'json-schema-rspec'
  spec.add_development_dependency 'mongoid'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rails', '~> 4.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'travis'
  spec.add_development_dependency 'yard'

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'bunny', '~> 2.5'
  spec.add_runtime_dependency 'key_path', '~> 1.2'
  spec.add_runtime_dependency 'parallel', '~> 1.18'
  spec.add_runtime_dependency 'semaphore', '~> 0.0.1'
  spec.add_runtime_dependency 'thread', '~> 0.2.2'
end
