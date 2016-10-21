# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for janus message class
    class JanusMessage < JanusError
      def initialize(message)
        super "[Message] Error create : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for janus message to_json
    class JanusMessageJson < JanusError
      def initialize(message)
        super "[Message] Error transform to json : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for janus message to_nice_json
    class JanusMessagePrettyJson < JanusError
      def initialize(message)
        super "[Message] Error transform to pretty json : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for janus message to_hash
    class JanusMessageHash < JanusError
      def initialize(message)
        super "[Message] Error transform to hash : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for janus message option
    class JanusMessageOption < JanusError
      def initialize(message)
        super "[Message] Error options to message : #{message}"
      end
    end
  end
end
