# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message for janus
  class Message
    # Instanciate an message
    # @param template_request [String] Name of request prepare
    # @param [Hash] Options to request
    # @option options [String] :session_id Identifier to session
    def initialize(template_request, options = nil)
      @request = {}
      @options = options
      @properties = Propertie.new
      load_request_file(template_request)
      prepare_request
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
    def load_request_file(template_request)
      @request = JSON.parse File.read Requests.instance.requests[template_request]
      Log.instance.debug "Opening request : #{to_nice_json}"
    end

    # Transform raw request in request to janus, so replace element <string>, <number>
    # and other with real value
    def prepare_request
      @request = Replace.new(@request).transform_request
      Log.instance.debug "Prepare request for janus : #{to_nice_json}"
    end
  end
end
