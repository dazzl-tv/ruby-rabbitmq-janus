# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Standard < Replace
        private

        # Replace classic elements
        def replace_element_classic
          super
          replace_handle if request.key?('handle_id')
          replace_candidate if request.key?('candidate')
          replace_sdp if request.key?('jsep')
        end

        # Replace handle integer
        def replace_handle
          request['handle_id'] = type.convert('handle_id', opts)
        rescue => message
          Tools::Log.instance.warn "Error handle replace : #{message}"
        end

        # Replace candidate
        # :reek:TooManyStatements
        def replace_candidate
          cdn = type.convert('candidate', opts)
          key = cdn[0]
          request['candidate'] = request.delete(key)
          request[key] = cdn[1]
        rescue => message
          Tools::Log.instance.warn "Error candidate replace : #{message}"
        end

        # Replace sdp in request
        def replace_sdp
          request['jsep']['sdp'] = type.convert('sdp')
        rescue => message
          Tools::Log.instance.warn "Error sdp replace : #{message}"
        end

        # Replace other element in request
        def replace_other
          values = opts['replace']
          running_hash(rewrite_key_to_string(values))
        rescue => message
          Tools::Log.instance.warn "Error REPLACE other field : #{message}"
        end

        # Adds other element to request
        def add_other
          values = opts['add']
          request['body'].merge!(values)
        rescue => message
          Tools::Log.instance.warn "Error ADD other field : #{message}"
        end

        # Rewrite key symbol to string
        def rewrite_key_to_string(node)
          Hash[
            node.map do |key, value|
              [key.to_s, value?(value)]
            end
          ]
        end

        # Test the value is an array
        def value?(value)
          value.is_a?(Hash) ? rewrite_key_to_string(value) : value
        end

        # Replace value in request Hash
        def running_hash(hash, parent = 'body')
          hash.each do |key, value|
            if value.is_a?(Hash)
              running_hash(value, new_parent(key, parent))
            else
              request[parent][key] = value unless key.eql? 'sdp'
            end
          end
        end

        # Return a key to hash parsing
        def new_parent(key, parent)
          "#{parent}#{'.' unless parent.empty?}#{key}"
        end

        # Test presence of key in many hash
        def test_presence?(presence_of_key)
          opts.key?(presence_of_key) && request.key?('body')
        end
      end
    end
  end
end
