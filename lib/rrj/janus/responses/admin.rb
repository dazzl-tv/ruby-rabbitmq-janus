# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Responses
      # Response for admin request
      #
      # @see Example request response https://janus.conf.meetecho.com/docs/admin.html
      class Admin < Event
        # @return [Array] List of sessions running in Janus Instance.
        def sessions
          read_data(__method__.to_s)
        end

        # @return [Array] List of handles running
        #   in one session in Janus Instance.
        def handles
          read_data(__method__.to_s)
        end

        # @return [Hash] Information to session/handle in Janus Instance.
        def info
          read_data(__method__.to_s)
        end

        # @return [Boolean] Information status to debug  mode for libnice.
        def libnice_debug
          read_data(__method__.to_s)
        end

        # @return [Boolean] Information status to debug mode
        #   in Janus Intance on the fly.
        def locking_debug
          read_data(__method__.to_s)
        end

        # @return [Boolean] Information about color in log messages.
        def log_colors
          read_data(__method__.to_s)
        end

        # @return [Integer] Level to debug mode to Janus Instance.
        def level
          read_data(__method__.to_s)
        end

        # @return [Boolean] Status to timestampping for log messages.
        def log_timestamps
          read_data(__method__.to_s)
        end

        # @return [Integer] Level to max nack queue configured.
        def max_nack_queue
          read_data(__method__.to_s)
        end

        # @return [Integer] No-media timer property.
        def no_media_timer
          read_data(__method__.to_s)
        end

        # @return [Integer] Timeout for session.
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
