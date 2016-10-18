# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Define errors to gems
  class RRJError < StandardError
    def initialize(message, level)
      super(message)
      Tools::Log.instance_method(level).bind(Tools::Log.instance).call(message)
    end
  end
end
