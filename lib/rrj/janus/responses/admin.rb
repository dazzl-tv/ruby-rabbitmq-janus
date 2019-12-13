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
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Sessions \
            unless key?('sessions')

          request['sessions']
        end

        # List of handles running in one session in Janus Instance.
        #
        # @return [Array] List of handles
        def handles
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Handles \
            unless key?('handles')

          request['handles']
        end

        # Info to session or handle in Janus Instance
        #
        # @return [Hash] Information to session/handle
        def info
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Admin::Info \
            unless key?('info')

          request['info']
        end
      end
    end
  end
end
