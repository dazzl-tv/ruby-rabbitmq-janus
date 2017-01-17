# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # This publisher send and read an message in queues
      class Publisher < BasePublisher
        # Intialize a publisher for sending and reading a message
        # @param [String] rabbit object
        #
        def initialize(exchange)
          super()
          @exchange = exchange.default_exchange
          @message = nil
          Tools::Log.instance.info "Create/Connect to queue -- #{reply.name}"
        end

        # Publish an message in queue
        def publish(request)
          Tools::Log.instance.info "Send request type : #{request.type}"
          @message = request
          @exchange.publish(@message.to_json,
                            request.options.merge!(reply_to: queue_name))
        rescue => error
          raise Errors::RabbitPublishMessage, error, request
        end

        private

        # Subscribe to queue selectd with a message
        def subscribe_to_queue
          reply.subscribe do |_delivery_info, propertie, payload|
            if @message.correlation.eql?(propertie.correlation_id)
              @response = JSON.parse payload
              lock.synchronize { condition.signal }
            end
          end
        end

        # Name to queue used for this publisher
        # @return [String] Name to queue used
        def queue_name
          reply.name
        end

        attr_accessor :message
      end
    end
  end
end

require 'rrj/rabbit/publish/admin'
require 'rrj/rabbit/publish/exclusive'
require 'rrj/rabbit/publish/non_exclusive'
