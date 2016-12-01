# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--tag ~level:admin'
end

RSpec::Core::RakeTask.new(:no_request_spec) do |t|
  t.rspec_opts = '--tag ~type:request'
end

task default: :spec
