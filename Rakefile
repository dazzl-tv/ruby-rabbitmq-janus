# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:config) do |t|
  t.rspec_opts = '--tag name:config'
end

RSpec::Core::RakeTask.new(:thread) do |t|
  t.rspec_opts = '--tag type:thread'
end

RSpec::Core::RakeTask.new(:set_session_timeout) do |t|
  t.rspec_opts = '--tag name:set_session_timeout'
end

RSpec::Core::RakeTask.new(:disallow_token) do |t|
  t.rspec_opts = '--tag name:disallow_token'
end

RSpec::Core::RakeTask.new(:admin) do |t|
  t.rspec_opts = '--tag name:admin'
end

RSpec::Core::RakeTask.new(:set_log_timestamps) do |t|
  t.rspec_opts = '--tag name:set_log_timestamps'
end

RSpec::Core::RakeTask.new(:start_text2pcap) do |t|
  t.rspec_opts = '--tag name:start_text2pcap'
end

RSpec::Core::RakeTask.new(:set_log_colors) do |t|
  t.rspec_opts = '--tag name:set_log_colors'
end

RSpec::Core::RakeTask.new(:stop_pcap) do |t|
  t.rspec_opts = '--tag name:stop_pcap'
end

RSpec::Core::RakeTask.new(:set_no_media_timer) do |t|
  t.rspec_opts = '--tag name:set_no_media_timer'
end

RSpec::Core::RakeTask.new(:pcap) do |t|
  t.rspec_opts = '--tag name:pcap'
end

RSpec::Core::RakeTask.new(:attach) do |t|
  t.rspec_opts = '--tag name:attach'
end

RSpec::Core::RakeTask.new(:list_sessions) do |t|
  t.rspec_opts = '--tag name:list_sessions'
end

RSpec::Core::RakeTask.new(:create) do |t|
  t.rspec_opts = '--tag name:create'
end

RSpec::Core::RakeTask.new(:event_admin) do |t|
  t.rspec_opts = '--tag name:event_admin'
end

RSpec::Core::RakeTask.new(:info) do |t|
  t.rspec_opts = '--tag name:info'
end

RSpec::Core::RakeTask.new(:add_token) do |t|
  t.rspec_opts = '--tag name:add_token'
end

RSpec::Core::RakeTask.new(:set_log_level) do |t|
  t.rspec_opts = '--tag name:set_log_level'
end

RSpec::Core::RakeTask.new(:set_locking_debug) do |t|
  t.rspec_opts = '--tag name:set_locking_debug'
end

RSpec::Core::RakeTask.new(:remove_token) do |t|
  t.rspec_opts = '--tag name:remove_token'
end

RSpec::Core::RakeTask.new(:answer) do |t|
  t.rspec_opts = '--tag name:answer'
end

RSpec::Core::RakeTask.new(:offer) do |t|
  t.rspec_opts = '--tag name:offer'
end

RSpec::Core::RakeTask.new(:set_libnice_debug) do |t|
  t.rspec_opts = '--tag name:set_libnice_debug'
end

RSpec::Core::RakeTask.new(:allow_token) do |t|
  t.rspec_opts = '--tag name:allow_token'
end

RSpec::Core::RakeTask.new(:janus_instance) do |t|
  t.rspec_opts = '--tag name:janus_instance'
end

RSpec::Core::RakeTask.new(:detach) do |t|
  t.rspec_opts = '--tag name:detach'
end

RSpec::Core::RakeTask.new(:destroy) do |t|
  t.rspec_opts = '--tag name:destroy'
end

RSpec::Core::RakeTask.new(:trickles) do |t|
  t.rspec_opts = '--tag name:trickles'
end

RSpec::Core::RakeTask.new(:standard) do |t|
  t.rspec_opts = '--tag name:standard'
end

RSpec::Core::RakeTask.new(:message) do |t|
  t.rspec_opts = '--tag name:message'
end

RSpec::Core::RakeTask.new(:errors) do |t|
  t.rspec_opts = '--tag name:'
end

RSpec::Core::RakeTask.new(:event) do |t|
  t.rspec_opts = '--tag name:event'
end

RSpec::Core::RakeTask.new(:response) do |t|
  t.rspec_opts = '--tag name:response'
end

RSpec::Core::RakeTask.new(:list_handles) do |t|
  t.rspec_opts = '--tag name:list_handles'
end

RSpec::Core::RakeTask.new(:list_tokens) do |t|
  t.rspec_opts = '--tag name:list_tokens'
end

RSpec::Core::RakeTask.new(:keepalive) do |t|
  t.rspec_opts = '--tag name:keepalive'
end

RSpec::Core::RakeTask.new(:logger) do |t|
  t.rspec_opts = '--tag name:logger'
end

RSpec::Core::RakeTask.new(:replace) do |t|
  t.rspec_opts = '--tag name:replace'
end

RSpec::Core::RakeTask.new(:set_max_nack_queue) do |t|
  t.rspec_opts = '--tag name:set_max_nack_queue'
end

RSpec::Core::RakeTask.new(:tricke) do |t|
  t.rspec_opts = '--tag name:tricke'
end

RSpec::Core::RakeTask.new(:handle_info) do |t|
  t.rspec_opts = '--tag name:handle_info'
end

RSpec::Core::RakeTask.new(:connect) do |t|
  t.rspec_opts = '--tag name:connect'
end

RSpec::Core::RakeTask.new(:listener) do |t|
  t.rspec_opts = '--tag name:listener'
end

RSpec::Core::RakeTask.new(:base_event) do |t|
  t.rspec_opts = '--tag name:base_event'
end

RSpec::Core::RakeTask.new(:publisher_admin) do |t|
  t.rspec_opts = '--tag name:publisher_admin'
end

RSpec::Core::RakeTask.new(:exclusive) do |t|
  t.rspec_opts = '--tag name:exclusive'
end

RSpec::Core::RakeTask.new(:non_exclusive) do |t|
  t.rspec_opts = '--tag name:non_exclusive'
end

RSpec::Core::RakeTask.new(:propertie) do |t|
  t.rspec_opts = '--tag name:propertie'
end

task spec: %I[config thread set_session_timeout disallow_token admin
              set_log_timestamps set_log_colors start_text2pcap attach
              set_no_media_timer stop_pcap pcap list_sessions create
              event_admin info add_token set_log_level set_locking_debug
              remove_token answer offer set_libnice_debug allow_token
              janus_instance detach destroy trickles standard message errors
              event response list_handles list_tokens keepalive logger
              replace set_max_nack_queue tricke handle_info connect listener
              base_event publisher_admin non_exclusive exclusive propertie]
