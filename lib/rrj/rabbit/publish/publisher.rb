# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # This publisher send and read an message in queues
      class Publisher < BasePublisher
        # Intialize a publisher for sending and reading a message
        #
        # @param [String] exchange Determine type exchange used for all
        #   transaction between gem and rabbitmq
        def initialize(exchange)
          super()
          @exchange = exchange.default_exchange
          @message = nil
          Tools::Log.instance.info "Create/Connect to queue -- #{reply.name}"
        end

        # Publish an message in queue
        #
        # @param [String] request JSON request sending to rabbitmq queue
        #
        # @raise [Errors::RabbitPublishMessage] If request is false the
        #   execption is calling
        def publish(request)
          Tools::Log.instance.info "Send request type : #{request.type}"
          @message = request
          @exchange.publish(@message.to_json,
                            request.options.merge!(reply_to: reply.name))
        rescue => error
          raise Errors::RabbitPublishMessage, error, request
        end

        private

        def subscribe_to_queue
          reply.subscribe do |_delivery_info, propertie, payload|
            propertie_correlation = p_correlation(propertie)
            if m_correlation.eql?(propertie_correlation)
              synchronize(payload)
            else
              Tools::Log.instance.error 'Response correlation ID mismatch (' \
                "#{m_correlation}!=#{propertie_correlation})"
            end
          end
        end

        def m_correlation
          @message.correlation
        end

        def p_correlation(propertie)
          propertie.correlation_id
        end

        def synchronize(payload)
          lock.synchronize do
            responses.push(JSON.parse(payload))
          end
          semaphore.signal
        end

        attr_accessor :message
      end
    end
  end
end

require 'rrj/rabbit/publish/admin'
require 'rrj/rabbit/publish/exclusive'
require 'rrj/rabbit/publish/non_exclusive'
