# frozen_string_literal: true

module RubyRabbitmqJanus
  # Format message request with good data to HASH format
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class Replace
    def initialize(request, options = nil)
      @request = request
      @opts = options
      Log.instance.debug "Option to replace in request #{@opts}"
    end

    def transform_request
      replaces
      @request
    end

    private

    # Replace element in hash request with information used for this transaction
    def replaces
      replace_classic
      replace_other if @opts.key?('other') && @request.key?('body')
    end

    def replace_classic
      replace_transaction if @request.key?('transaction')
      replace_session if @request.key?('session_id')
      replace_plugin if @request.key?('plugin')
      replace_handle if @request.key?('handle_id')
    end

    # Create an transaction string and replace in request field with an String format
    def replace_transaction
      @request['transaction'].replace [*('A'..'Z'), *('0'..'9')].sample(10).join
    rescue => message
      Log.instance.debug "Error transaction replace : #{message}"
    end

    # Read option session and replace in request
    def replace_session
      @request['session_id'] = @opts['session_id']
    rescue => message
      Log.instance.debug "Error session replace : #{message}"
    end

    def replace_plugin
      @request['plugin'] = Config.instance.options['janus']['plugins'][0]
    rescue => message
      Log.instance.debug "Error plugin replace : #{message}"
    end

    def replace_handle
      @request['handle_id'] = @opts['handle_id']
    rescue => message
      Log.instance.debug "Error handle replace : #{message}"
    end

    def replace_other
      running_hash(rewrite_key_to_string(@opts['other']))
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
