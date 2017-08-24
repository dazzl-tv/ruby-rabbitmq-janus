# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

ENV['MONGO'] = 'false' if ENV['MONGO'].nil?

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:no_request_spec) do |t|
  t.rspec_opts = '--tag ~type:request'
end

RSpec::Core::RakeTask.new(:info) do |t|
  t.rspec_opts = '--tag name:info'
end

RSpec::Core::RakeTask.new(:handle_info) do |t|
  t.rspec_opts = '--tag name:handle_info'
end

RSpec::Core::RakeTask.new(:handles) do |t|
  t.rspec_opts = '--tag name:handles'
end

RSpec::Core::RakeTask.new(:sessions) do |t|
  t.rspec_opts = '--tag name:sessions'
end

RSpec::Core::RakeTask.new(:set_locking_debug) do |t|
  t.rspec_opts = '--tag name:set_locking_debug'
end

RSpec::Core::RakeTask.new(:set_log_level) do |t|
  t.rspec_opts = '--tag name:set_log_level'
end

RSpec::Core::RakeTask.new(:tokens) do |t|
  t.rspec_opts = '--tag name:tokens'
end

RSpec::Core::RakeTask.new(:attach) do |t|
  t.rspec_opts = '--tag name:attach'
end

RSpec::Core::RakeTask.new(:create) do |t|
  t.rspec_opts = '--tag name:create'
end

RSpec::Core::RakeTask.new(:destroy) do |t|
  t.rspec_opts = '--tag name:destroy'
end

RSpec::Core::RakeTask.new(:detach) do |t|
  t.rspec_opts = '--tag name:detach'
end

RSpec::Core::RakeTask.new(:keepalive) do |t|
  t.rspec_opts = '--tag name:keepalive'
end

RSpec::Core::RakeTask.new(:offer) do |t|
  t.rspec_opts = '--tag name:offer'
end

RSpec::Core::RakeTask.new(:trickle) do |t|
  t.rspec_opts = '--tag name:trickle'
end

RSpec::Core::RakeTask.new(:trickles) do |t|
  t.rspec_opts = '--tag name:trickles'
end

RSpec::Core::RakeTask.new(:type_tools) do |t|
  t.rspec_opts = '--tag type:tools'
end

RSpec::Core::RakeTask.new(:type_cluster) do |t|
  t.rspec_opts = '--tag type:cluster'
end

RSpec::Core::RakeTask.new(:type_config) do |t|
  t.rspec_opts = '--tag type:config'
end

RSpec::Core::RakeTask.new(:type_responses) do |t|
  t.rspec_opts = '--tag type:responses'
end

RSpec::Core::RakeTask.new(:type_rabbit) do |t|
  t.rspec_opts = '--tag type:rabbit'
end

RSpec::Core::RakeTask.new(:type_message) do |t|
  t.rspec_opts = '--tag type:message'
end

RSpec::Core::RakeTask.new(:except_request) do |t|
  t.rspec_opts = '--tag ~type:request'
end

RSpec::Core::RakeTask.new(:instances) do |t|
  t.rspec_opts = '--tag instances:true'
end

RSpec::Core::RakeTask.new(:mongoid) do |t|
  ENV['MONGO'] = 'true'
  t.rspec_opts = '--tag orm:mongoid'
end

task default: :spec

task all: [:info, :handle_info, :sessions, :set_locking_debug,
           :set_log_level, :tokens, :attach, :create, :destroy,
           :detach, :keepalive, :offer, :trickle, :trickles,
           :except_request]
task two_instances: :instances
task mongo: :mongoid
