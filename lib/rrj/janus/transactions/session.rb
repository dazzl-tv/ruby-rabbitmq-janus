# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Manage a transaction
      # Manage a transaction with message if contains a session identifier
      class Session < Transaction
        # Opening a short transaction with rabbitmq and close when is ending
        #
        # @param [Boolean] exclusive
        #   Determine if the message is sending to a exclusive queue or not
        #
        # @yield Send a message to Janus
        def connect(exclusive)
          @exclusive = exclusive
          rabbit.transaction_short do
            choose_queue
            send_a_message { yield }
          end
        end
      end
    end
  end
end
