# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :attach.
  # This message attach a session betwen janus and customer
  # @example JSON sending
  #   {
  #       "janus" : "attach",
  #       "session_id": 2039999543573255,
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageAttach < MessageComplexJanus
    def initialize(transaction, correlation_id, session)
      super(:attach, transaction, correlation_id, session)
    end
  end
end
