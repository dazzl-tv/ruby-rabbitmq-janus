# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :destroy.
  # This message attach a session betwen janus and customer
  # @example JSON sending
  #   {
  #       "janus" : "destroy",
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageDestroy < MessageJanus
    def initialize(transaction, correlation_id, session)
      @type = :destroy
      @transaction = transaction
      @correlation_id = correlation_id
      @session = session
      set_plugin
    end

    # Write message type :destroy
    # @return [JSON] JSON request with type destroy
    def msg
      {
        janus: @type,
        session_id: @session,
        plugin: @plugin,
        transaction: @transaction
      }.to_json
    end
  end
end
