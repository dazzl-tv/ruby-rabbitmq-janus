# frozen_string_literal: true

require 'json'
require 'key_path'

module RubyRabbitmqJanus
  # Format message request with good data
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  class Replace
    def initialize(json_file, logs, opts)
      @request = JSON.parse(File.read(json_file))
      @opts = opts
      @logs = logs
      @path = nil
    end

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
      replace_specific_elements if @opts[:other_key]
    end

    # Create an transaction string and replace in request field with an String format
    def create_transaction
      @request['transaction'] = [*('A'..'Z'), *('0'..'9')].sample(10).join
    end

    def replace_standard_elements
      replace_element('session_id')
      replace_plugin
      replace_element(@opts['handle_id'] ? 'handle_id' : 'sender', 'handle_id')
    end

    def replace_specific_elements
      new_hash = rewrite_key_to_string(@opts[:other_key])
      @logs.debug "New Hash : #{new_hash}"
      update_request new_hash
      new_hash.each do |key, value|
        update_value_in_request key, value
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
      add_return('plugin', plugins[my_plugin.delete('<plugin[').delete(']').to_i]) \
        if my_plugin
    end

    # Rewrite key symbol to string
    def rewrite_key_to_string(node)
      Hash[
        node.map do |key, value|
          [key.to_s, value.is_a?(Hash) ? rewrite_key_to_string(value) : value]
        end
      ]
    end

    def update_value_in_request(key, value)
      @path = RubyRabbitmqJanus::Path.new key

      new_value = @request[@path.parent]
      new_data = RRJ::TypeData.new(new_value[@path.child], value)
      new_value.update(@path.childchild => new_data.format)
    end
  end
end
