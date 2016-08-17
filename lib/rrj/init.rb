# frozen_string_literal: true

require 'bunny'

module RRJ
  # Initialize gem
  class RRJ
    attr_reader :rabbit, :logs, :settings

    def initialize
      @logs = Log.new

      load_configuration_gem
      load_connection_rabbitmq
    end

    def interaction_send
      @rabbit.send
    end

    def interaction_listen
      @rabbit.listen
    end

    private

    def load_configuration_gem
      @settings = Config.new(@logs)
    end

    def load_connection_rabbitmq
      @rabbit = RabbitMQ.new(@settings, @logs)
    end
  end
end
