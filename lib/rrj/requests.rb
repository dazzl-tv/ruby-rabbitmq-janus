# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Load files json in config/request.
  # This file is used for sending a request to RabbitMQ
  # @!attribute [r] requests
  #   @return [RRJ::Request] Array to request
  class Requests
    attr_reader :requests

    # Define folder to request
    PATH_REQUEST = 'config/requests/'

    # Load all requests in folder
    def initialize(logs)
      @logs = logs
    end
  end
end
