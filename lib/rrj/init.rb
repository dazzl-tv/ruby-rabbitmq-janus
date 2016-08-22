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

      load_configuration
      load_rabbitmq
    end

    def sending_a_message
      @rabbit.send_message(:info)
      @rabbit.send_message(:create)
    end

    private

    # Loading Conf object
    def load_configuration
      @settings = Config.new(@logs)
    end

    # Loading RabbiMQ object
    def load_rabbitmq
      @rabbit = RabbitMQ.new(@settings, @logs)
    end
  end
end
