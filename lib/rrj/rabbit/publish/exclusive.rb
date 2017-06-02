# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Publish message
      #
      # Publish message in queue exclusive. Bunny create automaticaly a name for
      # this queue. The queue name like to 'amq.gen-1A456DGVHDVUS'.
      class PublishExclusive < Publisher
        # Initialize an queue exclusive and generated automaticaly by bunny
        #
        # @param [String] exchange Exchange used for the transaction
        # @param [String] name_queue Name to queue exclusive
        def initialize(exchange, name_queue)
          @reply = exchange.queue(name_queue, exclusive: true)
          super(exchange)
          subscribe_to_queue
        rescue
          raise Errors::Rabbit::PublishExclusive::Initialize
        end

        # Send an message to queue and waiting a response
        #
        # @param [String] request JSON request sending to rabbitmq queue
        #
        # @return [Janus::Response::Standard] response for an request reading
        #   by janus instance
        def publish(request)
          super(request)
          return_response
        rescue
          raise Errors::Rabbit::PublishExclusive::Publish
        end

        private

        attr_reader :reply
      end
    end
  end
end
