# frozen_string_literal: true
# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error primary for response
    class JanusResponse < JanusError
      def initialize(message)
        super "[Response] #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for response initalize
    class JanusResponseInit < JanusResponse
      def initialize(message)
        super "Error create object : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for simple message
    class JanusResponseSimple < JanusResponse
      def initialize(message)
        super "[#{message['code']}] #{message['reason']}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for plugin
    class JanusResponsePlugin < JanusResponse
      def initialize(message)
        super "[#{message['error_code']}] #{message['error']}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for json
    class JanusResponseJson < JanusResponse
      def initialize(message)
        super "Error transform to JSON : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for nice_json
    class JanusResponsePrettyJson < JanusResponse
      def initialize(message)
        super "Error transform to Pretty JSON : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for hash
    class JanusResponseHash < JanusResponse
      def initialize(message)
        super "Error transform to Hash : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for response plugin
    class JanusResponsePluginData < JanusResponse
      def initialize(message)
        super "Error data response : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for response data
    class JanusResponseDataId < JanusResponse
      def initialize(message)
        super "Error Data : #{message}"
      end
    end
  end
end
