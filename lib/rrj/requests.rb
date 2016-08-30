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
      @request = []
      Dir[File.join(PATH_REQUEST, '**', '*')].count do |file|
        loading_request(file) if File.file?(file)
      end
    end

    private

    def loading_request(file)
      @logs.info file.name
      @request.push file
    end
  end
end
