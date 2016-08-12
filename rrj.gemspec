lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rrj/version'

Gem::Specification.new do |spec|
  spec.name          = 'rrj'
  spec.version       = RRJ::VERSION
  spec.authors       = ['VAILLANT Jeremy']
  spec.email         = ['jeremy.vaillant@dazzl.tv']

  spec.summary       = 'Rails RabbitMQ Janus.'
  spec.description   = 'Connecting to a server rabbitmq server for sending and receiving datas to janus gateway.'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = 'rrj'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'overcommit', '~> 0.34.2'
  spec.add_development_dependency 'rubocop', '~> 0.42.0'

  spec.add_runtime_dependency 'bunny', '~> 2.5'
end
