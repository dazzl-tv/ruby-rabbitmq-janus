# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format for Handle request.
      # Manage sdp, handle_id, candidate or candidates.
      #
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Handle < Session
        private

        def replace_element_classic
          super
          replace_sdp if request.key?('jsep')
          replace_handle if request.key?('handle_id')
          replace_candidate \
            if request.key?('candidate') || request.key?('candidates')
        end

        def replace_handle
          request['handle_id'] = type.convert('handle_id', opts)
        end

        def replace_candidate
          cdn = type.convert(determine_key_candidate, opts)
          request[cdn[0]] = cdn[1]
          delete_key_unless
        end

        def replace_sdp
          request['jsep']['sdp'] = type.convert('sdp', opts)
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
