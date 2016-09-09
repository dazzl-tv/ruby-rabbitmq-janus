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
      @logs = Log.instance

      @settings = RubyRabbitmqJanus::Config.new(@logs)
      @requests = RubyRabbitmqJanus::Requests.new(@logs)
      @rabbit = RubyRabbitmqJanus::RabbitMQ.new(@settings, @requests.requests, @logs)

      @session = nil
    end

    # Send a message, to RabbitMQ, with a template JSON
    # @return [Hash] Contains information to request sending
    # @param template_used [String] Json used to request sending in RabbitMQ
    # @param [Hash] opts the options sending with a request
    # @option opts [String] :janus The message type
    # @option opts [String] :transaction The transaction identifier
    # @option opts [Hash] :data The option data to request
    def message_template_ask(template_used = 'info', opts = {})
      @rabbit.ask_request(template_used, opts)
    end

    # Send a message to RabbitMQ for reading a response
    # @return [Hash] Contains a response to request sending
    # @param info_request [Hash] Contains information to request sending
    # @option info_request [String] :janus The message type
    # @option info_request [String] :transaction The transaction identifier
    # @option info_request [Hash] :data The option data to request
    def message_template_response(info_request)
      @rabbit.ask_response(info_request)
    end

    # Manage a transaction with an plugin in janus
    # Is create an session and attach with a plugin configured in file conf to gem, then
    # when a treatment is complet is destroy a session
    # @yieldparam session_attach [Hash] Use a session created
    # @yieldreturn [Hash] Contains a result to transaction with janus server
    def transaction_plugin
      session_attach = response(ask('attach', response(ask('create'))))
      @session = yield(session_attach)
      @logs.debug "Session running : #{session_attach}"
      response(ask('destroy', response(ask('detach', @session))))
      @session
    end

    alias ask message_template_ask
    alias response message_template_response
  end
end
