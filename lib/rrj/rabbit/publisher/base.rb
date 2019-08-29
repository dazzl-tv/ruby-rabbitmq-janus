# frozen_string_literal: true

# :reek:UtilityFunction

# rubocop:disable Style/GuardClause

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # This publisher send and read an message in queues
      class Base < RubyRabbitmqJanus::Rabbit::BaseEvent
        # Intialize a publisher for sending and reading a message
        #
        # @param [String] exchange Determine type exchange used for all
        #   transaction between gem and rabbitmq
        def initialize(exchange)
          super()
          @exchange = exchange.default_exchange
          @message = nil
        rescue
          raise Errors::Rabbit::Publisher::Base::Initialize
        end

        # Publish an message in queue
        #
        # @param [String] request JSON request sending to rabbitmq queue
        #
        # @raise [Errors::RabbitPublishMessage] If request is false the
        #   execption is calling
        def publish(request)
          @message = request
          @exchange.publish(@message.to_json,
                            request.options.merge!(reply_to: reply.name))
        rescue
          raise Errors::Rabbit::Publisher::Base::Publish
        end

        private

        def subscribe_to_queue
          reply.subscribe do |_delivery_info, propertie, payload|
            test_correlation(m_correlation, p_correlation(propertie)) do
              synchronize(payload)
            end
          end
        end

        def m_correlation
          @message.correlation
        end

        def p_correlation(propertie)
          propertie.correlation_id
        end

        def test_correlation(m_cor, p_cor)
          if m_cor.eql?(p_cor)
            yield
          else
            raise Errors::Rabbit::Publisher::Base::TestCorrelation, m_cor, p_cor
          end
        end

        def synchronize(payload)
          lock.synchronize do
            responses.push(JSON.parse(payload))
          end
          semaphore.signal
        end

        attr_accessor :message
        attr_reader :reply
      end
    end
  end
end
# rubocop:enable Style/GuardClause

require 'rrj/rabbit/publisher/exclusive'
require 'rrj/rabbit/publisher/admin'
require 'rrj/rabbit/publisher/keepalive'
require 'rrj/rabbit/publisher/non_exclusive'
require 'rrj/rabbit/publisher/janus_instance'
