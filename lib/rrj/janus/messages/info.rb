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
  class MessageInfo < MessageJanus
    def initialize
      super
      @type = :info
    end

    # Write message type :info
    # @return [JSON] JSON request with type info
    def msg
      { janus: @type, transaction: @transaction }.to_json
    end
  end
end
