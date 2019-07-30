# frozen_string_literal: true

# Loads files RRJ and write first message in log,
# then initialize binary

require 'rrj/info'
require 'ruby_rabbitmq_janus'

::Log = if @logger_default
          RubyRabbitmqJanus::Tools::Log.instance
        else
          require_relative @logger_path
          @logger_class.constantize.instance
        end

Log.info "RRJ Version : #{RubyRabbitmqJanus::VERSION}"
Log.info RubyRabbitmqJanus::BANNER

require File.join(File.dirname(__FILE__), '..', '..', 'binary')

begin
  bin = RubyRabbitmqJanus::Binary.new
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
  Log.fatal '!! Fail to start RRJ threads !!'
  Log.fatal exception
  exit 1
end
