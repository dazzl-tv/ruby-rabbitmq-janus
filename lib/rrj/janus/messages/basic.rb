# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Send a message whitout no session
  class MessageBasicJanus < MessageJanus
    # Prepare transaction, correlation_id and type
    def initialize(type)
      super(type)
    end

    # Write a basic JSON message
    def msg
      {
        janus: @type,
        transaction: @transaction
      }.to_json
    end

    # Give information about session created
    def information
      {
        correlation_id: @correlation_id,
        transaction: @transaction,
        reply_to: @reply_queue.name
      }
    end
  end
end
