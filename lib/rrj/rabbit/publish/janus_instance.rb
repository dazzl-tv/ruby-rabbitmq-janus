# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # Publisher to queue `janus-instance`
      class JanusInstance < Base
        def initialize(exchange)
          @reply = exchange.queue(Tools::Config.instance.queue_janus_instance)
          super(exchange)
        rescue
          raise Errors::Rabbit::Publisher::JanusInstance::Initialize
        end

        def publish(request)
          super(request)
        rescue
          raise Errors::Rabbit::Publisher::JanusInstance::Publish
        end
      end
    end
  end
end
