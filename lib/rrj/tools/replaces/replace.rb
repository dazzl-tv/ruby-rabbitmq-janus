# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Tools for replace elements in request
    module Replaces
      # # Prepare request
      #
      # Tools for replace elements in request sending to Rabbitmq. It's used
      # for basic request. (with session_id or not).
      #
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Replace
        # Initialize tool replace
        #
        # @param [Hash] request Request parsing before sending to RabbitMQ/Janus
        # @param [Hash] options Elements to be replaced in request
        def initialize(request, options = {})
          @request = request
          @opts = options
          @type = Tools::Type.new(@request)
          Tools::Log.instance.debug "Element to replace : #{@opts}"
        end

        # Replace element in hash request with information used for this
        # transaction
        #
        # @return [Hash] request with element replace
        def transform_request
          replace_element_classic
          unless @opts.empty?
            replace_other if test_presence?('replace')
            add_other if test_presence?('add')
          end
          @request
        end

        private

        attr_reader :request, :opts, :type

        def test_presence?(presence_of_key)
          @opts.key?(presence_of_key) && @request.key?('body')
        end

        def replace_element_classic
          replace_transaction if @request.key?('transaction')
          replace_session if @request.key?('session_id')
          replace_plugin if @request.key?('plugin')
        end

        # Create an transaction string and replace in request field with an
        # String format
        def replace_transaction
          @request['transaction'] = @type.convert('transaction')
        rescue => message
          Tools::Log.instance.warn "Error transaction replace : #{message}"
        end

        # Read option session and replace in request
        def replace_session
          @request['session_id'] = @type.convert('session_id', @opts)
        rescue => message
          Tools::Log.instance.warn "Error session replace : #{message}"
        end

        # Replace plugin string
        def replace_plugin
          @request['plugin'] = @type.convert('plugin')
        rescue => message
          Tools::Log.instance.warn "Error plugin replace : #{message}"
        end
      end
    end
  end
end

require 'rrj/tools/replaces/standard'
require 'rrj/tools/replaces/admin'
