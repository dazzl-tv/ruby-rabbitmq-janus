# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :info.
  # This message request information to Janus server
  # @example JSON sending
  #   {
  #       "janus" : "info",
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageInfo < MessageBasicJanus
    def initialize
      super(:info)
    end
  end
end
