# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :info
  class Info < MessageJanus
    # Write message type :info
    def msg
      { janus: :info, transaction: @transaction }.to_s
    end
  end
end
