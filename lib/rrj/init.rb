# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem
  # @!attribute [r] session
  #   @return [Hash] Response to request sending in transaction
  class RRJ
    attr_reader :session

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      Log.instance
      Config.instance
      Requests.instance

      @rabbit = RabbitMQ.new

      @session = nil
    end

    # Send a message, to RabbitMQ, with a template JSON
    # @return [Hash] Contains information to request sending
    # @param template_used [String] Json used to request sending in RabbitMQ
    # @param [Hash] opts the options sending with a request
    # @option opts [String] :janus The message type
    # @option opts [String] :transaction The transaction identifier
    # @option opts [Hash] :data The option data to request
    def message_template_ask_sync(template_used = 'info', opts = {})
      @rabbit.ask_request_sync(template_used, opts)
    end

    # Send a message to RabbitMQ for reading a response
    # @return [Hash] Contains a response to request sending
    # @param info_request [Hash] Contains information to request sending
    # @option info_request [String] :janus The message type
    # @option info_request [String] :transaction The transaction identifier
    # @option info_request [Hash] :data The option data to request
    def message_template_response(info_request)
      Log.instance.warn "InfoRequest ;p #{info_request}"
      @rabbit.ask_response(info_request)
    end

    # Manage a transaction with an plugin in janus
    # Is create an session and attach with a plugin configured in file conf to gem, then
    # when a treatment is complet is destroy a session
    # @yieldparam session_attach [Hash] Use a session created
    # @yieldreturn [Hash] Contains a result to transaction with janus server
    def transaction_plugin
      session_attach = response_sync(ask_sync('attach',
                                              response_sync(ask_sync('create'))))
      @session = yield(session_attach)
      Log.instance.debug "Session running : #{session_attach}"
      response_sync(ask_sync('destroy', response_sync(ask_sync('detach', @session))))
      @session
    end

    def message_template_ask_async(template_used = 'info', opts = {})
      @rabbit.ask_request_async(template_used, opts)
    end

    alias ask_async message_template_ask_async
    alias ask_sync message_template_ask_sync
    alias response_sync message_template_response
  end
end
