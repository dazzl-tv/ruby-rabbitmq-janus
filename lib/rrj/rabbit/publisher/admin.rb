# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This publisher send and read an message in admin queues
      class Admin < Base
        # Initialize an queue non eclusive for admin/monitor API with Janus
        #
        # @param [String] exchange Exchange used for the transaction
        def initialize(exchange)
          @reply = exchange.queue('', exclusive: true)
          # @reply = exchange.queue(Tools::Config.instance.queue_admin_from)
          super(exchange)
          subscribe_to_queue
        rescue
          raise Errors::Rabbit::Publisher::Admin::Initialize
        end

        # Send an message to queue and waiting a response
        #
        #
        # @param [String] request JSON request sending to rabbitmq queue
        #
        # @return [Janus::Response::Admin] response for an request reading
        #   by janus instance
        def publish(request)
          message = request
          exchange.publish(message.to_json,
                           request.options.merge!(reply_to: reply.name))
          return_response
        rescue
          raise Errors::Rabbit::Publisher::Admin::Pusblish
        end
      end
    end
  end
end
