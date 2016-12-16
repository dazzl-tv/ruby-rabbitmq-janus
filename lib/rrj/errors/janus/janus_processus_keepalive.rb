# frozen_string_literal: true
# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    # Define errors for keepalive class
    class Keepalive < Janus
      # Write a message with a tag keepalive in log
      def initialize(message)
        super "[Keepalive] #{message}"
      end
    end

    # Define error for session_return method
    class KeepaliveSessionReturn < Keepalive
      # Initialize a error message
      def initialize(message)
        super "Fixnum Session return failed : #{message}"
      end
    end

    # Define error for create_session method
    class KeepaliveCreateSession < Keepalive
      # Initialize a error message
      def initialize(message)
        super "Session create error : #{message}"
      end
    end

    # Define a error in loop_session method
    class KeepaliveLoopSession < Keepalive
      # Initialize a error message
      def initialize(message)
        super "Loop session failed (session will die) : #{message}"
      end
    end

    # Define a error in message keepalive created
    class KeepaliveMessage < Keepalive
      # Initialize a error message
      def initialize(message)
        super "Keepalive message failed : #{message}"
      end
    end
  end
end
