# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:no_request_spec) do |t|
  t.rspec_opts = '--tag ~type:request'
end

RSpec::Core::RakeTask.new(:info) do |t|
  t.rspec_opts = '--tag name:info'
end

task default: :spec
