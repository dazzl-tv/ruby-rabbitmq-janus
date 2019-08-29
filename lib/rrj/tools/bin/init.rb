# frozen_string_literal: true

# Loads files RRJ and write first message in log,
# then initialize binary

require 'rrj/rails' # defined?(::Rails::Engine)
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
  Log.fatal '!! Fail to start RRJ Thread Janus Instance management !!'
  Log.fatal exception
  exit 1
end
