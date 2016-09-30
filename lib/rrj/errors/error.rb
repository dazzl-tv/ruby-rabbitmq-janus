# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Define errors to gems
  class RRJError < StandardError
    attr_reader :message
    attr_reader :level

    def initialize
      @message = nil
      super(@message)
      log = RubyRabbitmqJanus::Log.instance_method(level)
      log.bind(RubyRabbitmqJanus::Log.instance).call(@message)
    end
  end
end
