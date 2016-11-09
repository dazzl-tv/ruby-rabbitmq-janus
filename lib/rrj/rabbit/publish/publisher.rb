# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This publisher send and read an message in queues
      class Publisher < BasePublisher
        # Intialize a publisher for sending and reading a message
        def initialize(exchange)
          super
          @exchange = exchange.default_exchange
          @message = @reply = nil
          Tools::Log.instance.debug 'Create/Connect to queue'
        end

        # Publish an message in queue
        def send_a_message(request)
          Tools::Log.isntance.info "Send request type : #{request.type}"
          @message = request
          @exchange.publish(@message.to_json,
                            request.options.merge!(reply_to: @reply.name))
          return_response
        end

        private

        # Subscribe to queue selectd with a message
        def subscribe_to_queue
          @reply.subscribe do |_delivery_info, propertie, payload|
            if @message.correlation.eql?(propertie.correlation_id)
              lock.synchronize do
                @response = JSON.parse payload
                condition.signal
              end
            end
          end
        end

        attr_accessor :message
      end
    end
  end
end

require 'admin'
require 'exclusive'
require 'non_exclusive'
