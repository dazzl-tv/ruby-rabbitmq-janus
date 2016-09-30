# frozen_string_literal: true

require 'json'
require 'key_path'

module RubyRabbitmqJanus
  # Format message request with good data
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class Replace
    def initialize(json_file, opts)
      @request = JSON.parse(File.read(json_file))
      @opts = opts
      @path = nil
    end

    # Return request to Hash format
    def to_hash
      Hash @request
    end

    # Return request to JSON format
    def to_json
      replaces
      @request.to_json
    end

    private

    # Replace element in json request with information used by transaction
    def replaces
      create_transaction
      return unless @opts
      replace_standard_elements
      replace_specific_elements if @opts.key?(:other_key) && @request.key?('body')
    end

    # Create an transaction string and replace in request field with an String format
    def create_transaction
      @request['transaction'] = [*('A'..'Z'), *('0'..'9')].sample(10).join
    end

    # Replace a standart element in request
    def replace_standard_elements
      replace_element('session_id')
      replace_plugin
      replace_element(@opts['handle_id'] ? 'handle_id' : 'sender', 'handle_id')
    end

    # Replace element specific in request
    def replace_specific_elements
      if request_as_replace_specific
        new_hash = rewrite_key_to_string(@opts[:other_key])
        running_hash(new_hash)
      end
    end

    # Replace a session_id field with an Integer
    def replace_element(value, value_replace = value)
      add_return(value_replace, value_data_or_precise(value)) \
        if @request[value_replace]
    end

    # Format the response return
    def value_data_or_precise(key)
      @opts[key] || @opts['data']['id']
    end

    # Format the json used for request sending
    def add_return(key, value)
      @request[key] = value
      @request.merge!(key => value)
    end

    # Replace plugin used for transaction
    def replace_plugin
      my_plugin = @request['plugin']
      if my_plugin
        number = TypeData.new(my_plugin)
        add_return('plugin', Config.instance.options['janus']['plugins'][number.format])
      end
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

    # Test if request as specific elements
    def request_as_replace_specific
      ['<string>', '<number>'].each do |value|
        return true if @request['body'].value?(value)
      end
    end

    # This is method smells of :reek:UtilityFunction
    def new_parent(key, parent)
      "#{parent}#{'.' unless parent.empty?}#{key}"
    end
  end
end
