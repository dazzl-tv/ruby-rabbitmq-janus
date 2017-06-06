# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for admin request
      class Admin < Standard
        # List of sessions running in Janus Instance.
        #
        # @return [Array] List of sessions
        def sessions
          request['sessions']
        rescue
          raise Errors::Janus::ResponseAdmin::Sessions
        end

        # List of handles running in one session in Janus Instance.
        #
        # @return [Array] List of handles
        def handles
          request['handles']
        rescue
          raise Errors::Janus::ResponseAdmin::Handles
        end

        # Info to session or handle in Janus Instance
        #
        # @return [Hash] Information to session/handle
        def info
          request['info']
        rescue
          raise Errors::Janus::ResponseAdmin::Info
        end
      end
    end
  end
end
