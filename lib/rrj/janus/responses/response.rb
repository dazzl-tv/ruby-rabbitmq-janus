# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Read and parse a response to janus.
      #
      # Read a message in rabbitmq queue. This message is formatted to JSON
      # or Hash format. For developpment it's possible to used a `nice` JSON.
      class Response
        # Instanciate a response
        #
        # @param [Hash] response_janus
        #   Request parsing after Janus/RabbitMQ receive a response to request
        #   sending by user
        def initialize(response_janus)
          @request = response_janus
        rescue => error
          Tools::Log.instance.debug "Request error [initialize] : #{@request}"
          raise Errors::JanusResponseInit, error
        else
          Tools::Log.instance.debug "Response return : #{to_json}"
        end

        # Return request to json format
        #
        # @return [String] Response to JSON format
        def to_json
          @request.to_json
        rescue => error
          raise Errors::JanusResponseJson, [error, @request]
        end

        # Return request to json format with nice format
        #
        # @return [String] Response to JSON format with indent
        def to_nice_json
          JSON.pretty_generate to_hash
        rescue => error
          raise Errors::JanusResponsePrettyJson, error
        end

        # Return request to hash format
        #
        # @return [Hash] Response to Hash foramt
        def to_hash
          @request
        rescue => error
          raise Errors::JanusResponseHash, [error, @request]
        end

        private

        attr_accessor :request
      end
    end
  end
end

require 'rrj/janus/responses/standard'
require 'rrj/janus/responses/admin'
require 'rrj/janus/responses/event'
