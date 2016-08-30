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
      @requests = {}

      @logs.info "Loading all requests in : #{PATH_REQUEST}"

      Dir[File.join(PATH_REQUEST, '**', '*')].count do |file|
        @requests[File.basename(file, '.json').to_sym] = File.path(file)
      end
      @requests
    end
  end
end
