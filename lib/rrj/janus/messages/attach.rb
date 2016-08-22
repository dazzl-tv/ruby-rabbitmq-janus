# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :attach.
  # This message attach a session betwen janus and customer
  # @example JSON sending
  #   {
  #       "janus" : "attach",
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageAttach < MessageJanus
    def initialize(transaction, correlation_id, session)
      @type = :attach
      @transaction = transaction
      @correlation_id = correlation_id
      @session = session
      set_plugin
    end

    # Write message type :create
    # @return [JSON] JSON request with type create
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
