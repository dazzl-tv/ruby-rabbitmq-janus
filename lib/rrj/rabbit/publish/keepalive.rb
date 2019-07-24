# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Publish message for keepalive thread
      #
      # The name to queue it's created automatically by Bunny GEM
      #
      # @see KeepaliveThread
      class Keepalive < Publisher
        def initialize(exchange)
          @reply = exchange.queue('', exclusive: true)
          super(exchange)
          subscribe_to_queue
        rescue
          raise Errors::Rabbit::Publisher::Keepalive::Initialize
        end

        def publish(request)
          super(request)
          return_response
        rescue
          raise Errors::Rabbit::Publisher::Keepalive::Publish
        end

        private

        attr_reader :reply
      end
    end
  end
end
