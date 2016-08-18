# frozen_string_literal: true

require 'bunny'

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
    attr_reader :rabbit, :logs, :settings

    # Returns a new instance of RRJ
    def initialize
      @logs = Log.instance

      load_configuration
      load_rabbitmq
    end

    def send_message_test
      @logs.write 'Publish message to queue to-janus'
      @rabbit.send_message
    end

    def listen_message_test
      @logs.write 'Listen message to queue from-janus'
      @rabbit.listen_queue
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
