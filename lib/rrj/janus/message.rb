# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message for janus
  class Message
    attr_reader :type

    # Instanciate an message
    # @param template_request [String] Name of request prepare
    # @param [Hash] options Options to request (replace element or add in body)
    # @option options [String] :session_id Identifier to session
    # @option options [String] :handle_id Identifier to session manipulate
    # @option options [Hash] :other Element contains in request sending to janus
    # @example Initialize a message
    #   Message.new('test', {
    #     "session_id": 42,
    #     "handle_id": 42,
    #     "replace": {
    #       "audio": false,
    #       "video": true
    #     },
    #     "add": {
    #       "subtitle": true
    #     })
    def initialize(template_request, options = {})
      @request = {}
      @type = template_request
      @properties = Rabbit::Propertie.new
      load_request_file
      prepare_request(options)
    end

    # Return request to json format
    def to_json
      @request.to_json
    end

    # Return request to json format with nice format
    def to_nice_json
      JSON.pretty_generate to_hash
    end

    # Return request to hash format
    def to_hash
      @request
    end

    # Return options to message for rabbitmq
    def options
      @properties.options
    end

    private

    # Load raw request
    def load_request_file
      @request = JSON.parse File.read Tools::Requests.instance.requests[@type]
      Tools::Log.instance.debug "Opening request : #{to_json}"
    end

    # Transform raw request in request to janus, so replace element <string>, <number>
    # and other with real value
    def prepare_request(options)
      @request = Tools::Replace.new(@request, options).transform_request
      Tools::Log.instance.debug "Prepare request for janus : #{to_json}"
    end
  end
end
