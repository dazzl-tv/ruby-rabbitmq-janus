# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This class work with janus and send a series of message for session
      # level
      class Session < Transaction
        # Connect to session and post an message
        def session_connect(exclusive)
          rabbit.transaction_short do
            choose_queue(exclusive)
            send_a_message(exclusive) { yield }
          end
        end
      end
    end
  end
end
