# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Send a message whitout no session
  class MessageBasicJanus < MessageJanus
    # Prepare transaction, correlation_id and type
    def initialize(type)
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
      @type = type
    end

    # Write a basic JSON message
    def msg
      {
        janus: @type,
        transaction: @transaction
      }.to_json
    end
  end
end
