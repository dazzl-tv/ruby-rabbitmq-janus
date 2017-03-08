# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage a transaction
      #
      # Manage a transaction with message if contains a session identifier
      class Session < Transaction
        # Initialize a transaction with handle
        #
        # @param [Fixnum] session
        #   Use a session identifier for created message
        def initialize(exclusive, session)
          super(session)
          @exclusive = exclusive
        end

        # Opening a short transaction with rabbitmq and close when is ending
        #
        # @yield Send a message to Janus
        def connect
          rabbit.transaction_short do
            choose_queue
            yield
          end
        end

        def publish_message(type, options = {})
          msg = Janus::Messages::Standard.new(type, opts.merge!(options))
          response = read_response(publisher.publish(msg))
          Janus::Responses::Standard.new(response)
        end

        private

        def opts
          { 'session_id' => session }
        end
      end
    end
  end
end
