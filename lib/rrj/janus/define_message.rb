# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class DefineMessage
    # Initialize all message posibility to sending a janus server
    def initialize(logs)
      @logs = logs
      @create_an_message_type = {
        basic: [:create, :info],
        complex: [:attach, :destroy]
      }
    end

    # Create a message with type and with option if exists
    # @param type [Symbol] The type of message
    # @param [Hash] opts_requests the option to create request with more paramters
    # @option opts_request [String] :transaction Identifier to transaction
    # @option opts_requests [String] :correlation_id Identifier correlation
    # @option opts_requests [String] :session Identifier session
    def type_message(type, opts_request = {})
      type_message_basic(type) if @create_an_message_type[:basic].include? type
      type_message_complex(type, opts_request) \
        if @create_an_message_type[:complex].include? type
    end

    private

    # Return a message ask
    def type_message_basic(type)
      @logs.info "Message basic - type #{type}"
      @messages_basic = {
        info: MessageInfo.new,
        create: MessageCreate.new
      }
      @msg = @messages_basic[type.to_sym]
      @logs.debug @msg
    end

    # Return a complex message
    # @param [Hash] opts_requests the option to create request with more paramters
    # @option opts_request [String] :transaction Identifier to transaction
    # @option opts_requests [String] :correlation_id Identifier correlation
    # @option opts_requests [String] :session Identifier session
    def type_message_complex(type, opts_request = {})
      @logs.info "Message complex - type #{type}"
      @messages_complex = {
        destroy: MessageDestroy.new(opts_request),
        attach: MessageAttach.new(opts_request)
      }
      @messages_complex[type.to_sym]
    end
  end
end
