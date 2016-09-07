# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem
  # @!attribute [r] rabbit
  #   @return [RubyRabbitmqJanus::RabbitMQ] Object RabbitMQ for connection to RabbitMQ
  #   server
  # @!attribute [r] logs
  #   @return [RubyRabbitmqJanus::Log] Object Log for manipulate logs
  # @!attribute [r] settings
  #   @return [RubyRabbitmqJanus::Config] Object Config to gem
  class RRJ
    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      @logs = Log.instance

      @settings = RubyRabbitmqJanus::Config.new(@logs)
      @requests = RubyRabbitmqJanus::Requests.new(@logs)
      @rabbit = RubyRabbitmqJanus::RabbitMQ.new(@settings, @requests.requests, @logs)
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

    alias ask message_template_ask
    alias response message_template_response
  end
end
