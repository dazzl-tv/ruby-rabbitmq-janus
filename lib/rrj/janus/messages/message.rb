# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for create message for Janus
    module Messages
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Create a message for janus.
      #
      # Create a message, in hash format, and sending to json format.
      # It's loading file base and change elements and configure message for
      # used in rabbitmq.
      #
      # @!attribute [r] type
      #   @return [String]
      #     Type to request sending ('base::info', 'peer::trickle')
      #
      # @see file:/config/requests.md For more information to type requests
      #   used.
      class Message
        attr_reader :type

        # Instanciate an message
        #
        # @param template_request [String] Name of request prepare
        # @param [Hash] options Options to request
        # @option options [String] :session_id Identifier to session
        # @option options [String] :handle_id Identifier to session manipulate
        # @option options [Hash] :other Element contains in request sending
        #
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
        # def initialize(template_request, options = { 'instance' => 1 })
        def initialize(template_request, options = {})
          @request = {}
          @type = template_request
          @properties = Rabbit::Propertie.new(options['instance'])
          load_request_file
          prepare_request(options)
        end

        # Return request to json format
        #
        # @return [String] Request to JSON format
        def to_json(*_args)
          @request.to_json
        end

        # Return request to json format with nice format
        #
        # @return [String] Request to JSON format with indent
        def to_nice_json
          JSON.pretty_generate to_hash
        end

        # Return request to hash format
        #
        # @return [Hash] Request to Hash format
        def to_hash
          @request
        end

        # Return correlation to message
        #
        # @return [String] Correlation string
        def correlation
          @properties.correlation
        end

        private

        attr_accessor :properties, :request

        def load_request_file
          @request = request_instance
          ::Log.debug "Opening request : #{to_json}"
        end

        def prepare_request(_options)
          ::Log.debug "Prepare request for janus : #{to_json}"
        end

        def request_instance
          JSON.parse File.read Tools::Requests.instance.requests[@type]
        end

        def find_instance(options)
          if options.key?('instance')
            options['instance']
          else
            Models::JanusInstance.find_by_session(options['session_id'])
          end
        end
      end
    end
  end
end

require 'rrj/janus/messages/standard'
require 'rrj/janus/messages/admin'
