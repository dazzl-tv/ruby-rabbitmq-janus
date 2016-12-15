# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an exception for janus message class
    class JanusMessage < JanusError
      # Initialize a error for janus message module
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[Message] #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an exception for janus message to_json
    class JanusMessageJson < JanusMessage
      # Initialize a error for janus message in to_json
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error transform to json : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an exception for janus message to_nice_json
    class JanusMessagePrettyJson < JanusMessage
      # Initialize a error for janus message in to_nice_json
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error transform to pretty json : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an exception for janus message to_hash
    class JanusMessageHash < JanusMessage
      # Initialize a error for janus message in to_hash
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Error transform to hash : #{message}"
      end
    end
  end
end
