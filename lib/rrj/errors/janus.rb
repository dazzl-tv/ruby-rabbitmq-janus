# frozen_string_literal: true
# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to message sending and response to janus
    class JanusError < RRJError
      def initialize(message)
        super message, :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for simple message
    class JanusSimple < JanusError
      def initialize(message)
        super "JANUS [#{message['code']}] #{message['reason']}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error for plugin
    class JanusPlugin < JanusError
      def initialize(message)
        super "JANUS PLUGIN [#{message['error_code']}] #{message['error']}"
      end
    end
  end
end
