lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gem/janus/version'

Gem::Specification.new do |spec|
  spec.name          = 'gem-janus'
  spec.version       = Gem::Janus::VERSION
  spec.authors       = ['VAILLANT Jeremy']
  spec.email         = ['jeremy.vaillant@dazzl.tv']

  spec.summary       = 'Connecting to a server janus'
  spec.description   = 'Connecting to a server for janus Dazzl.tv'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'overcommit', '~> 0.34.2'
  spec.add_development_dependency 'rubocop', '~> 0.42.0'
end
