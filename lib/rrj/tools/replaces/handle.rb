# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Handle < Session
        private

        # Replace classic elements
        def replace_element_classic
          super
          replace_sdp if request.key?('jsep')
          replace_handle if request.key?('handle_id')
          replace_candidate \
            if request.key?('candidate') || request.key?('candidates')
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
          cdn = type.convert(determine_key_candidate, opts)
          key = cdn[0]
          request[key] = cdn[1]
          delete_key_unless
        rescue => message
          Tools::Log.instance.warn "Error candidate replace : #{message}"
        end

        # Replace sdp in request
        def replace_sdp
          request['jsep']['sdp'] = type.convert('sdp', opts)
        rescue => message
          Tools::Log.instance.warn "Error sdp replace : #{message}"
        end

        def determine_key_candidate
          if request.key?('candidate')
            'candidate'
          else
            'candidates'
          end
        end

        def delete_key_unless
          singular = request['candidate']
          plural = request['candidates']
          if singular.eql?('<array>')
            request.delete('candidate')
          elsif plural.eql?('candidates')
            request.delete['candidates']
          end
        end
      end
    end
  end
end
