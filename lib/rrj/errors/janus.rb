# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module for manipulate error given by Janus
  module ErrorJanus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to message sending and response to janus
    class JanusError < RRJError
      def initialize(message)
        super message, :fatal
      end
    end

    # Define an error for simple message
    class JanusSimple < JanusError
      # :reek:FeatureEnvy
      def initialize(message)
        super "JANUS [#{message['code']}] #{message['reason']}"
      end
    end

    # Define an error for plugin
    class JanusPlugin < JanusError
      # :reek:FeatureEnvy
      def initialize(message)
        super "JANUS PLUGIN [#{message['error_code']}] #{message['error']}"
      end
    end
  end
end
