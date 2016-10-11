# frozen_string_literal: true

module RubyRabbitmqJanus
  # Format message request with good data to HASH format
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class Replace
    def initialize(request, options = {})
      @request = request
      @opts = options
      Log.instance.debug "Option to replace in request #{@opts}"
    end

    # Replace element in hash request with information used for this transaction
    # @return HASH request with element replace
    def transform_request
      replace_classic
      replace_other if @opts.key?('other') && @request.key?('body')
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
      Log.instance.debug 'Replace transaction'
      @request['transaction'].replace [*('A'..'Z'), *('0'..'9')].sample(10).join
    rescue => message
      Log.instance.debug "Error transaction replace : #{message}"
    end

    # Read option session and replace in request
    def replace_session
      Log.instance.debug 'Replace session'
      @request['session_id'] = @opts['session_id']
    rescue => message
      Log.instance.debug "Error session replace : #{message}"
    end

    # Replace plugin string
    def replace_plugin
      Log.instance.debug 'Replace plugin'
      @request['plugin'] = Config.instance.options['janus']['plugins'][0]
    rescue => message
      Log.instance.debug "Error plugin replace : #{message}"
    end

    # Replace handle integer
    def replace_handle
      Log.instance.debug 'Replace handle'
      @request['handle_id'] = @opts['handle_id']
    rescue => message
      Log.instance.debug "Error handle replace : #{message}"
    end

    # Replace other element in request
    def replace_other
      values = @opts['other']
      Log.instance.debug "Replace other element : #{values}"
      running_hash(rewrite_key_to_string(values))
    rescue => message
      Log.instance.debug "Error other field : #{message}"
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
    def running_hash(hash, parent = '')
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
  end
end
