# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :destroy.
  # This message attach a session betwen janus and customer
  # @example JSON sending
  #   {
  #       "janus" : "destroy",
  #       "session_id": 2039999543573255,
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageDestroy < MessageComplexJanus
    def initialize(opts = {})
      super(:destroy, opts)
    end
  end
end
