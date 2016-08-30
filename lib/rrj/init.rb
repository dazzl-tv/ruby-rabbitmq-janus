# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem
  # @!attribute [r] rabbit
  #   @return [RRJ::RabbitMQ] Object RabbitMQ for connection to RabbitMQ server
  # @!attribute [r] logs
  #   @return [RRJ::Log] Object Log for manipulate logs
  # @!attribute [r] settings
  #   @return [RRJ::Config] Object Config to gem
  class RRJ
    # Returns a new instance of RRJ
    def initialize
      @logs = Log.instance

      @settings = Config.new(@logs)
      @requests = Requests.new(@logs)
      @rabbit = RabbitMQ.new(@settings, @requests.requests, @logs)
    end

    # Send a message with a template JSON
    def message_template(template_used = 'info')
      @rabbit.send(template_used)
    end
  end
end
