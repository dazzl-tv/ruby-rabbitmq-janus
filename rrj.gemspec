lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rrj/info'

Gem::Specification.new do |spec|
  spec.name          = RubyRabbitmqJanus::GEM_NAME
  if ENV['TRAVIS'] && !ENV['TRAVIS_BRANCH'].eql?('master')
    spec.version     = "#{RubyRabbitmqJanus::VERSION}-#{ENV['TRAVIS_BUILD_NUMBER']}"
  else
    spec.version     = RubyRabbitmqJanus::VERSION
  end
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

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5', '>= 3.5.0'
  spec.add_development_dependency 'overcommit', '~> 0.34.2'
  spec.add_development_dependency 'rubocop', '~> 0.42.0'
  spec.add_development_dependency 'yard', '~> 0.9.5'
  spec.add_development_dependency 'reek', '~> 4.2', '>= 4.2.4'
  spec.add_development_dependency 'fuubar', '~> 2.2'
  spec.add_development_dependency 'aruba', '~> 0.14.2'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'json-schema', '~> 2.6', '>= 2.6.2'
  spec.add_development_dependency 'json-schema-rspec', '~> 0.0.4'
  spec.add_development_dependency 'activesupport', '~> 4.2', '>= 4.2.7.1'
  spec.add_development_dependency 'travis', '~> 1.8', '>= 1.8.4'

  spec.add_runtime_dependency 'bunny', '~> 2.5'
  spec.add_runtime_dependency 'key_path', '~> 1.2'
  spec.add_runtime_dependency 'thread', '~> 0.2.2'
end
