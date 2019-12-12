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
        # Instantiate a response
        #
        # @param [Hash] response_janus
        #   Request parsing after Janus/RabbitMQ receive a response to request
        #   sending by user
        def initialize(response_janus)
          @request = response_janus
          error?
        rescue
          raise Errors::Janus::Response::Initializer
        end

        # Return request to json format
        #
        # @return [String] Response to JSON format
        def to_json(*_args)
          @request.to_json
        rescue
          raise Errors::Janus::Response::ToJson
        end

        # Return request to json format with nice format
        #
        # @return [String] Response to JSON format with indent
        def to_nice_json
          JSON.pretty_generate to_hash
        rescue
          raise Errors::Janus::Response::ToNiceJson
        end

        # Return request to hash format
        #
        # @return [Hash] Response to Hash format
        def to_hash
          @request
        rescue
          raise Errors::Janus::Response::ToHash
        end

        # Return request object error
        #
        #  @return [Hash] Part of response content in error
        def error
          @request['error']
        end

        # Return request error code
        #
        #  @return [Integer] Code error
        def error_code
          error['code'].to_i
        end

        # Return request error reason
        #
        #  @return [String] Reason error
        def error_reason
          error['reason']
        end

        # Test if response it's an error
        #
        # @return [Boolean]
        def error?
          errors if @request['janus'].match?('error')
        end

        private

        def errors
          klass = RubyRabbitmqJanus::Janus::Responses::Errors.new
          klass.send("_#{@request['error']['code']}", self)
        end

        attr_accessor :request
      end
    end
  end
end

require 'rrj/janus/responses/error'
require 'rrj/janus/responses/standard'
require 'rrj/janus/responses/admin'
require 'rrj/janus/responses/event'
require 'rrj/janus/responses/rspec'
