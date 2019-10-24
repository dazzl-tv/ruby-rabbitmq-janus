# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Exclude all spec with type :thread
RSpec::Core::RakeTask.new(:spec) do |_t|
end

# Exclude all spec with type :thread
RSpec::Core::RakeTask.new(:classic) do |t|
  t.rspec_opts = '--tag ~type:thread'
end

# Include just spec with type :thread
RSpec::Core::RakeTask.new(:concurrency) do |t|
  t.rspec_opts = '--tag type:thread'
end

task default: :spec
task request: :classic
task thread: :concurrency
