# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Define errors to gems
  class GemError < StandardError
    # Initialize errors in gem
    def initialize
      super
    end

    # Define an error if the configuration file is not here
    def config_file_not_found
    end
  end

  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Define errors to message sending and response to janus
  class JanusError < GemError
    attr_reader :code
    attr_reader :reason
  end
end
