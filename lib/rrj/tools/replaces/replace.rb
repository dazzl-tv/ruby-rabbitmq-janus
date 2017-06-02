# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Tools for replace elements in request
    module Replaces
      # # Prepare request
      #
      # Tools for replace elements in request sending to Rabbitmq. It's a basic
      # class. Manage just transaction element.
      #
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Replace
        # Initialize tool replace.
        #
        # @param [Hash] request Request parsing before sending to RabbitMQ/Janus
        # @param [Hash] options Elements to be replaced in request
        def initialize(request, options = {})
          @request = request
          @opts = options
          @type = Tools::Type.new(@request)
        rescue
          raise Errors::Tools::Replace::Initializer
        end

        # Replace element in hash request with information used for this
        # transaction.
        #
        # @return [Hash] request with element replace
        def transform_request
          replace_element_classic
          unless @opts.empty?
            replace_other if test_presence?('replace')
            add_other if test_presence?('add')
          end
          @request
        rescue
          raise Errors::Tools::Replace::TransformRequest
        end

        private

        attr_reader :request, :opts, :type

        def test_presence?(presence_of_key)
          @opts.key?(presence_of_key) && @request.key?('body') &&
            !@opts[presence_of_key].blank?
        end

        def replace_other
          values = @opts['replace']
          running_hash(rewrite_key_to_string(values))
        rescue => message
          Tools::Log.instance.warn "Error REPLACE other field : #{message}"
        end

        def add_other
          values = @opts['add']
          @request['body'].merge!(values)
        rescue => message
          Tools::Log.instance.warn "Error ADD other field : #{message}"
        end

        def rewrite_key_to_string(node)
          Hash[
            node.map do |key, value|
              [key.to_s, value?(value)]
            end
          ]
        end

        def value?(value)
          value.is_a?(Hash) ? rewrite_key_to_string(value) : value
        end

        def running_hash(hash, parent = 'body')
          hash.each do |key, value|
            if value.is_a?(Hash)
              running_hash(value, new_parent(key, parent))
            else
              @request[parent][key] = value unless key.eql? 'sdp'
            end
          end
        end

        def new_parent(key, parent)
          "#{parent}#{'.' unless parent.empty?}#{key}"
        end

        def replace_element_classic
          replace_transaction if @request.key?('transaction')
        end

        def replace_transaction
          @request['transaction'] = @type.convert('transaction')
        rescue => message
          Tools::Log.instance.warn "Error transaction replace : #{message}"
        end
      end
    end
  end
end

require 'rrj/tools/replaces/session'
require 'rrj/tools/replaces/handle'
require 'rrj/tools/replaces/admin'
