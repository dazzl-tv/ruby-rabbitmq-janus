# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Tools for replace elements in request
    module Replaces
      # Tools for replace elements in request sending to Rabbitmq
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Replace
        # Initialize tool replace
        def initialize(request, options = {})
          @request = request
          @opts = options
          @type = Tools::Type.new(@request)
          Tools::Log.instance.debug "Element to replace : #{@opts}"
        end

        # Replace element in hash request with information used for this
        # transaction
        # @return HASH request with element replace
        def transform_request
          replace_classic
          unless @opts.empty?
            replace_other if test_presence?('replace')
            add_other if test_presence?('add')
          end
          @request
        end

        private

        attr_reader :request, :opts, :type

        # Replace basic elements
        def replace_classic
          replace_transaction if @request.key?('transaction')
          replace_session if @request.key?('session_id')
          replace_plugin if @request.key?('plugin')
        end

        # Create an transaction string and replace in request field with an
        # String format
        def replace_transaction
          @request['transaction'].replace \
            [*('A'..'Z'), *('0'..'9')].sample(10).join
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
          @request['plugin'] = Tools::Config.instance.plugin_at
        rescue => message
          Tools::Log.instance.warn "Error plugin replace : #{message}"
        end
      end
    end
  end
end

require 'rrj/tools/replaces/standard'
require 'rrj/tools/replaces/admin'
