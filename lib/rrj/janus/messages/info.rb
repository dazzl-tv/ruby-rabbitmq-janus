# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :info
  class Info < MessageJanus
    # Precise type message
    TYPE = :info

    # Write message type :info
    # @return [JSON] JSON request with type info
    def msg
      { janus: TYPE, transaction: @transaction }.to_json
    end
  end
end
