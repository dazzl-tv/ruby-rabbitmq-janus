# frozen_string_literal: true

# Loads files RRJ and write first message in log,
# then initialize binary

require 'rrj/info'
require 'ruby_rabbitmq_janus'

# rubocop:disable Naming/ConstantName
::Log = if @logger_default
          RubyRabbitmqJanus::Tools::Log.instance
        else
          require_relative @logger_path
          @logger_class.constantize.instance
        end
# rubocop:enable Naming/ConstantName

Log.info "RRJ Version : #{RubyRabbitmqJanus::VERSION}"
Log.info "\r\n#{RubyRabbitmqJanus::BANNER}"

require File.join(File.dirname(__FILE__), '..', '..', 'binary')

begin
  Log.info 'Load events public queue classes'
  bin = RubyRabbitmqJanus::Binary.new
  Log.info "Load file : #{File.join(Dir.pwd, LISTENER_PATH)}"
  require File.join(Dir.pwd, LISTENER_PATH)

  Log.info 'Listen public queue in thread'
  actions = RubyRabbitmqJanus::ActionEvents.new.actions
  RubyRabbitmqJanus::Janus::Concurrencies::Event.instance.run(&actions)
rescue => exception
  Log.fatal '!! Fail to start RRJ Thread listen public queue !!'
  Log.fatal exception
  exit 1
end

begin
  Log.info \
    'Prepare to listen events in queue : ' + \
    RubyRabbitmqJanus::Tools::Config.instance.queue_janus_instance
  rabbit = RubyRabbitmqJanus::Rabbit::Connect.new
  rabbit.start
  listener = RubyRabbitmqJanus::Rabbit::Listener::JanusInstance.new(rabbit)
  Log.info 'Loop events provided by Janus queues'
  loop do
    listener.listen_events do |event, response|
      Log.debug "Event : #{event}"
      Log.debug "Response : #{response.to_hash}"
      bin.update_instance(response.to_hash)
    end
  end
rescue => exception
  Log.fatal '!! Fail to start RRJ Thread Janus Instance management !!'
  Log.fatal exception
  exit 1
end
