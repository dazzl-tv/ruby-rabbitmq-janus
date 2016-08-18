# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :create
  class Create < MessageJanus
    # Precise type message
    TYPE = :create

    # Write message type :create
    # @return [JSON] JSON request with type create
    def msg
      { janus: TYPE, transaction: @transaction }.to_json
    end
  end
end
