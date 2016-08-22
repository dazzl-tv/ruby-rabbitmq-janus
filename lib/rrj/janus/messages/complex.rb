# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Send a message whit a session
  # @!attribute [r] session
  #   session identifier used by janus
  class MessageComplexJanus < MessageJanus
    attr_reader :session

    # Send a message with transaction, correlation_id and session exisiting
    def initialize(type, opts)
      @transaction = opts[:transaction]
      @correlation_id = opts[:correlation_id]
      @session = opts[:session]
      @type = type
    end

    # Write a complex JSON message
    def msg
      {
        janus: @type,
        session_id: @session.to_i,
        transaction: @transaction
      }.to_json
    end
  end
end
