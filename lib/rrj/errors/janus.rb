# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module for manipulate error given by Janus
  module ErrorJanus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to message sending and response to janus
    class JanusError < RRJError
      attr_reader :code
      attr_reader :reason
    end
  end
end
