# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for admin request
      class Admin < Standard
        # List of sessions running in Janus Instance.
        #
        # @return [Hash] List of sessions
        def sessions
          request['sessions']
        end

        # List of handles running in one session in Janus Instance.
        #
        # @return [Hash] List of handles
        def handles
          request['handles']
        end

        # Info to session or handle in Janus Instance
        #
        # @return [Hash] Information to session/handle
        def info
          request['info']
        end
      end
    end
  end
end
