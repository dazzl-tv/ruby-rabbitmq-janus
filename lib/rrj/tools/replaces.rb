# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Format message request with good data to HASH format
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    class Replace
      def initialize(request, options = {})
        @request = request
        @opts = options
        Tools::Log.instance.debug "Option to replace in request #{@opts}"
      end

      # Replace element in hash request with information used for this transaction
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

      # Replace classic elements
      def replace_classic
        replace_transaction if @request.key?('transaction')
        replace_session if @request.key?('session_id')
        replace_plugin if @request.key?('plugin')
        replace_handle if @request.key?('handle_id')
      end

      # Create an transaction string and replace in request field with an String format
      def replace_transaction
        Tools::Log.instance.debug 'Replace transaction'
        @request['transaction'].replace [*('A'..'Z'), *('0'..'9')].sample(10).join
      rescue => message
        Tools::Log.instance.debug "Error transaction replace : #{message}"
      end

      # Read option session and replace in request
      def replace_session
        Tools::Log.instance.debug 'Replace session'
        @request['session_id'] = @opts['session_id']
      rescue => message
        Tools::Log.instance.debug "Error session replace : #{message}"
      end

      # Replace plugin string
      def replace_plugin
        Tools::Log.instance.debug 'Replace plugin'
        @request['plugin'] = Tools::Config.instance.options['janus']['plugins'][0]
      rescue => message
        Tools::Log.instance.debug "Error plugin replace : #{message}"
      end

      # Replace handle integer
      def replace_handle
        Tools::Log.instance.debug 'Replace handle'
        @request['handle_id'] = @opts['handle_id']
      rescue => message
        Tools::Log.instance.debug "Error handle replace : #{message}"
      end

      # Replace other element in request
      def replace_other
        values = @opts['replace']
        Tools::Log.instance.debug "Replace other element : #{values}"
        running_hash(rewrite_key_to_string(values))
      rescue => message
        Tools::Log.instance.debug "Error REPLACE other field : #{message}"
      end

      def add_other
        values = @opts['add']
        Tools::Log.instance.debug "Add other element : #{values}"
        @request['body'].merge!(values)
      rescue => message
        Tools::Log.instance.debug "Error ADD other field : #{message}"
      end

      # Rewrite key symbol to string
      def rewrite_key_to_string(node)
        Hash[
          node.map do |key, value|
            [key.to_s, value.is_a?(Hash) ? rewrite_key_to_string(value) : value]
          end
        ]
      end

      # Replace value in request Hash
      def running_hash(hash, parent = 'body')
        hash.each do |key, value|
          if value.is_a?(Hash)
            running_hash(value, new_parent(key, parent))
          else
            @request[parent][key] = value
          end
        end
      end

      # This is method smells of :reek:UtilityFunction
      def new_parent(key, parent)
        "#{parent}#{'.' unless parent.empty?}#{key}"
      end

      # This method of :reek:NilCheck
      def test_presence?(presence_of_key)
        @opts.key?(presence_of_key) && \
          @request.key?('body') && \
          !@opts[presence_of_key].nil?
      end
    end
  end
end
