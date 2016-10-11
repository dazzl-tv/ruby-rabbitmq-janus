# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message for janus
  class Message
    attr_reader :type

    # Instanciate an message
    # @param template_request [String] Name of request prepare
    # @param [Hash] Options to request
    # @option options [String] :session_id Identifier to session
    # @option options [String] :handle_id Identifier to session manipulate
    def initialize(template_request, options = {})
      @request = {}
      @type = template_request
      @properties = Propertie.new
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
      @request = JSON.parse File.read Requests.instance.requests[@type]
      Log.instance.debug "Opening request : #{to_json}"
    end

    # Transform raw request in request to janus, so replace element <string>, <number>
    # and other with real value
    def prepare_request(options)
      @request = Replace.new(@request, options).transform_request
      Log.instance.debug "Prepare request for janus : #{to_json}"
    end
  end
end
