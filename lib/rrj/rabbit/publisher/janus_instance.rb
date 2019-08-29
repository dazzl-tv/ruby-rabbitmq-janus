# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # Publisher to queue `janus-instance`
      class JanusInstance
        def initialize
          @rabbit = RubyRabbitmqJanus::Rabbit::Connect.new
        rescue
          raise Errors::Rabbit::Publisher::JanusInstance::Initialize
        end

        def publish(data)
          @rabbit.start
          channel = @rabbit.channel
          queue = channel.queue(Tools::Config.instance.queue_janus_instance)
          channel.default_exchange.publish(data.to_json,
                                           routing_key: queue.name)
          @rabbit.close
        rescue
          raise Errors::Rabbit::Publisher::JanusInstance::Publish
        end
      end
    end
  end
end
