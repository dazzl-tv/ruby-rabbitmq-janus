# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for admin request
      #
      # @see Example request response https://janus.conf.meetecho.com/docs/admin.html
      class Admin < Standard
        # List of sessions running in Janus Instance.
        #
        # @return [Array] List of sessions
        def sessions
          read_data(__method__.to_s)
        end

        # List of handles running in one session in Janus Instance.
        #
        # @return [Array] List of handles
        def handles
          read_data(__method__.to_s)
        end

        # Info to session or handle in Janus Instance
        #
        # @return [Hash] Information to session/handle
        def info
          read_data(__method__.to_s)
        end

        def libnice_debug
          read_data(__method__.to_s)
        end

        def locking_debug
          read_data(__method__.to_s)
        end

        def log_colors
          read_data(__method__.to_s)
        end

        def level
          read_data(__method__.to_s)
        end

        def log_timestamps
          read_data(__method__.to_s)
        end

        def max_nack_queue
          read_data(__method__.to_s)
        end

        def no_media_timer
          read_data(__method__.to_s)
        end

        def timeout
          read_data(__method__.to_s)
        end

        private

        def read_data(key)
          raise build_exception(key) unless key?(key)

          request[key]
        end

        def build_exception(key)
          "RubyRabbitmqJanus::Errors::Janus::Responses::Admin::#{key.camelize}"
            .constantize
        end
      end
    end
  end
end
