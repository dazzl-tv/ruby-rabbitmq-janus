# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message returning content an error
  class ResponseError < ResponseJanus
    # Customize a message reading in RabbitMQ queue
    def receive(_channel)
    end
  end
end
